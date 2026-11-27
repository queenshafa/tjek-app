import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/surface_card.dart';
import '../../domain/attendance_policy.dart';
import '../../domain/attendance.dart';
import '../providers.dart';

class HistoryTile extends ConsumerWidget {
  const HistoryTile({super.key, required this.record});
  final Attendance record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = record.createdAt?.toUtc().add(const Duration(hours: 7));
    final isLate =
        record.createdAt != null &&
        AttendancePolicy.status(record.createdAt!) == AttendanceStatus.late;

    final photoAsync = ref.watch(photoProvider(record.id));

    return SurfaceCard(
      padding: 12,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => PhotoDialog(id: record.id),
        ),
        child: Row(
          children: [
            // Thumbnail foto di sebelah kiri
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 54,
                height: 54,
                color: Colors.black.withValues(alpha: 0.06),
                child: photoAsync.when(
                  data: (bytes) => Image.memory(
                    bytes,
                    fit: BoxFit.cover,
                    width: 54,
                    height: 54,
                  ),
                  loading: () => const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  error: (_, _) => const Icon(
                    Icons.image_not_supported_outlined,
                    size: 22,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Informasi tanggal, waktu, dan status di tengah
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    date == null
                        ? 'Menunggu konfirmasi server'
                        : DateFormat('EEEE, d MMM', 'id').format(date),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date == null
                        ? 'Menyimpan…'
                        : '${DateFormat('HH:mm:ss').format(date)} WIB | ${record.statusLabel}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface
                          .withValues(alpha: 0.75),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Ikon status di sebelah kanan
            Icon(
              record.createdAt == null || isLate
                  ? Icons.schedule
                  : Icons.check_circle_outline,
              size: 24,
              color: record.createdAt == null
                  ? Colors.grey
                  : isLate
                  ? const Color(0xFFD50000) // Merah untuk Telat
                  : const Color(0xFF2EBD00), // Hijau untuk Tepat Waktu
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

class PhotoDialog extends ConsumerWidget {
  const PhotoDialog({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AlertDialog(
    title: const Text('Bukti kehadiran'),
    content: ref
        .watch(photoProvider(id))
        .when(
          data: (bytes) => ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(bytes, fit: BoxFit.contain),
          ),
          loading: () => const SizedBox(
            height: 150,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => const Text('Foto belum dapat dimuat.'),
        ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Tutup'),
      ),
    ],
  );
}
