import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import '../../../core/enter_motion.dart';
import '../../../core/theme_picker.dart';
import 'widgets/history_tile.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => EnterMotion(
    child: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(
              child: Text(
                'Jejak hadir',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
            ),
            ThemePicker(),
          ],
        ),
        const SizedBox(height: 10),
        const Text('Foto, jam masuk, dan status absenmu.', style: TextStyle()),
        const SizedBox(height: 28),
        ...ref
            .watch(attendanceProvider)
            .when(
              data: (items) => items.isEmpty
                  ? [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 64),
                        child: Column(
                          children: [
                            Icon(Icons.history, size: 56),
                            SizedBox(height: 18),
                            Text('Belum ada absensi.'),
                            SizedBox(height: 8),
                            Text(
                              'Kalau sudah di sekolah, absen lewat Beranda, ya.',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ]
                  : items.map((item) => HistoryTile(record: item)).toList(),
              loading: () => [const Center(child: CircularProgressIndicator())],
              error: (_, _) => [
                TextButton(
                  onPressed: () => ref.invalidate(attendanceProvider),
                  child: const Text('Gagal memuat. Ketuk untuk mencoba lagi.'),
                ),
              ],
            ),
      ],
    ),
  );
}
