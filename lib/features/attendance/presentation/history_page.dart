import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import '../../../core/enter_motion.dart';
import '../../../core/theme_picker.dart';
import 'widgets/history_tile.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : const Color(0xFFF5F5F5),
      body: SafeArea(
        child: EnterMotion(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -.5,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          attendanceAsync.maybeWhen(
                            data: (items) => '${items.length} total absen',
                            orElse: () => 'Memuat total absen...',
                          ),
                          style: TextStyle(fontSize: 14, color: textColor),
                        ),
                      ],
                    ),
                  ),
                  const ThemePicker(),
                ],
              ),
              const SizedBox(height: 24),
              ...attendanceAsync.when(
                data: (items) => items.isEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 64),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.history,
                                size: 56,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Belum ada absensi.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Kalau sudah di sekolah, absen lewat Beranda, ya.',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    : items
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: HistoryTile(record: item),
                            ),
                          )
                          .toList(),
                loading: () => [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
                error: (_, _) => [
                  TextButton(
                    onPressed: () => ref.invalidate(attendanceProvider),
                    child: const Text(
                      'Gagal memuat. Ketuk untuk mencoba lagi.',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
