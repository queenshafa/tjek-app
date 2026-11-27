import 'package:material_ui/material_ui.dart';

import '../../domain/attendance.dart';
import '../../domain/attendance_policy.dart';

class MonthSummary extends StatelessWidget {
  const MonthSummary({super.key, required this.items});

  final List<Attendance> items;

  @override
  Widget build(BuildContext context) {
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
            isDark: false,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _statCard(value: '$late', label: 'Telat', isDark: true),
        ),
      ],
    );
  }

  Widget _statCard({
    required String value,
    required String label,
    required bool isDark,
  }) {
    const orange = Color(0xFFF36C0B);

    return Container(
      height: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(15),
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
              color: isDark ? orange : Colors.black,
            ),
          ),

          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
