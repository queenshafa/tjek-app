import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/clock_provider.dart';
import '../../domain/attendance_policy.dart';

class WeeklyCalendar extends ConsumerWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = AttendancePolicy.wib(
      ref.watch(clockProvider).asData?.value ?? DateTime.now(),
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    const orange = Color(0xFFED7014);

    // Senin sampai Jumat pada minggu berjalan.
    final monday = now.subtract(Duration(days: now.weekday - 1));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E22) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDark
            ? Border.all(color: Colors.white.withValues(alpha: 0.08))
            : null,
      ),
      child: Row(
        children: List.generate(5, (index) {
          final date = monday.add(Duration(days: index));
          final isToday =
              date.day == now.day &&
              date.month == now.month &&
              date.year == now.year;

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: isToday
                    ? (isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : const Color(0xFFF7F7F7))
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('EEE', 'id')
                        .format(date)
                        .replaceFirstMapped(
                          RegExp(r'^\w'),
                          (match) => match.group(0)!.toUpperCase(),
                        ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
