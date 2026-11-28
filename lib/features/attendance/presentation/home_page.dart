import 'package:klock_app/core/brand_header.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth_providers.dart';
import '../../../core/enter_motion.dart';
import 'providers.dart';
import 'widgets/clock_card.dart';
import 'widgets/check_in_card.dart';
import 'widgets/month_summary.dart';
import 'widgets/weekly_calendar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(studentNameProvider).split(' ').first;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return EnterMotion(
      child: Container(
        color: isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : const Color(0xFFF4F4F4),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Apa Kabar, $name?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -.5,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Yuk, catat kehadiranmu hari ini!',
                          style: TextStyle(fontSize: 14, color: textColor),
                        ),
                      ],
                    ),
                  ),
                  const BrandHeader(),
                ],
              ),

              const SizedBox(height: 24),

              // Weekly Calendar
              const WeeklyCalendar(),

              const SizedBox(height: 8),

              // Clock
              const ClockCard(),

              const SizedBox(height: 22),

              // Attendance Check-in
              const CheckInCard(),

              const SizedBox(height: 10),

              // History Button
              SizedBox(
                height: 65,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/history');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFED7014),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Lihat Riwayat',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Attendance Statistics
              ref
                  .watch(attendanceProvider)
                  .when(
                    data: (items) => MonthSummary(items: items),
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Catatan belum bisa dimuat. Cek koneksimu, ya.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
