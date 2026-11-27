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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SurfaceCard(
        padding: 8,
        child: ListTile(
          leading: Icon(
            record.createdAt == null
                ? Icons.schedule
                : AttendancePolicy.status(record.createdAt!) ==
                      AttendanceStatus.late
                ? Icons.schedule
                : Icons.check_circle_outline,
            color:
                record.createdAt != null &&
                    AttendancePolicy.status(record.createdAt!) ==
                        AttendanceStatus.late
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            date == null
                ? 'Menunggu konfirmasi server'
                : DateFormat('EEEE, d MMM', 'id').format(date),
          ),
          subtitle: Text(
            date == null
                ? 'Menyimpan…'
                : '${DateFormat('HH:mm:ss').format(date)} WIB · ${record.statusLabel}',
          ),
          trailing: const Icon(Icons.photo_outlined, size: 20),
          onTap: () => showDialog<void>(
            context: context,
            builder: (_) => PhotoDialog(id: record.id),
          ),
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
          data: (bytes) => Image.memory(bytes, fit: BoxFit.contain),
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
