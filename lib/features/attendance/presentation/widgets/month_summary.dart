import 'package:material_ui/material_ui.dart';

import '../../domain/attendance.dart';
import '../../domain/attendance_policy.dart';

class MonthSummary extends StatelessWidget {
  const MonthSummary({super.key, required this.items});

  final List<Attendance> items;

  @override
  Widget build(BuildContext context) {
    final appIsDark = Theme.of(context).brightness == Brightness.dark;
    final confirmed = items.where((item) => item.createdAt != null).toList();

    final late = confirmed
        .where(
          (item) =>
              AttendancePolicy.status(item.createdAt!) == AttendanceStatus.late,
        )
        .length;

    final onTime = confirmed.length - late;

    return Row(
      children: [
        Expanded(
          child: _statCard(
            value: '$onTime',
            label: 'Tepat waktu',
            isBlackCard: false,
            appIsDark: appIsDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            value: '$late',
            label: 'Telat',
            isBlackCard: true,
            appIsDark: appIsDark,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required String value,
    required String label,
    required bool isBlackCard,
    required bool appIsDark,
  }) {
    const orange = Color(0xFFED7014);

    final bgColor = isBlackCard
        ? const Color(0xFF0B0B0B)
        : (appIsDark ? const Color(0xFF1E1E22) : Colors.white);

    final valueColor = isBlackCard
        ? orange
        : (appIsDark ? Colors.white : Colors.black);

    final labelColor = (isBlackCard || appIsDark) ? Colors.white : Colors.black;

    return Container(
      height: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
        border: appIsDark
            ? Border.all(
                color: Colors.white.withValues(
                  alpha: isBlackCard ? 0.12 : 0.08,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w800,
              height: 1,
              letterSpacing: -1.5,
              color: valueColor,
            ),
          ),
          Text(label, style: TextStyle(fontSize: 15, color: labelColor)),
        ],
      ),
    );
  }
}
