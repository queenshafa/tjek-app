import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/clock_provider.dart';
import '../../domain/attendance.dart';
import '../../domain/attendance_policy.dart';
import '../providers.dart';
import '../capture_page.dart';
import 'scan_emblem.dart';

class CheckInCard extends ConsumerWidget {
  const CheckInCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(attendanceProvider);

    final now = AttendancePolicy.wib(
      ref.watch(clockProvider).asData?.value ?? DateTime.now(),
    );

    Attendance? today;

    for (final record in records.asData?.value ?? <Attendance>[]) {
      final date = record.createdAt == null
          ? null
          : AttendancePolicy.wib(record.createdAt!);

      if (date?.year == now.year &&
          date?.month == now.month &&
          date?.day == now.day) {
        today = record;
      }
    }

    final isLate =
        today?.createdAt != null &&
        AttendancePolicy.status(today!.createdAt!) == AttendanceStatus.late;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Icon(
            today == null
                ? Icons.sentiment_satisfied_alt_rounded
                : Icons.check_circle_rounded,
            color: const Color(0xFFF36C0B),
            size: 55,
          ),

          const SizedBox(height: 2),

          Text(
            today == null ? 'Absen dulu, yuk!' : today.statusLabel,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            today == null
                ? 'Absen pake kamera depan, cek fotonya, langsung kirim deh! Kalau lewat 07:00 WIB, berarti telat, ya!'
                : 'Absenmu sudah tersimpan. Kamu bisa lihat foto dan jam masuknya di Riwayat.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 13),

          SizedBox(
            width: double.infinity,
            height: 37,
            child: FilledButton(
              onPressed: today != null || !records.hasValue
                  ? null
                  : () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const CapturePage(),
                      ),
                    ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                disabledBackgroundColor: Colors.white70,
                disabledForegroundColor: Colors.black54,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Text(
                today == null ? 'Absen' : 'Sudah absen',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          if (records.hasError) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(attendanceProvider),
              child: const Text(
                'Belum terhubung · Coba lagi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
