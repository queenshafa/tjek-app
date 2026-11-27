import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:one_clock/one_clock.dart' show AnalogClock;

import '../../../../core/clock_provider.dart';
import '../../domain/attendance_policy.dart';

class ClockCard extends ConsumerWidget {
  const ClockCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = AttendancePolicy.wib(
      ref.watch(clockProvider).asData?.value ?? DateTime.now(),
    );

    const orange = Color(0xFFF36C0B);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(now),
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          color: orange,
                          letterSpacing: -1.5,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, bottom: 15),
                        child: Text(
                          DateFormat(':ss').format(now),
                          style: const TextStyle(
                            fontSize: 15,
                            color: orange,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Live Analog Clock
              AnalogClock(
                width: 58,
                height: 58,
                isLive: false,
                datetime: now,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2.5),
                ),
                hourHandColor: Colors.black,
                minuteHandColor: Colors.black,
                secondHandColor: orange,
                showSecondHand: true,
                showNumbers: false,
                showAllNumbers: false,
                showTicks: true,
                showDigitalClock: false,
              ),
            ],
          ),

          const SizedBox(height: 2),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Masuk jam 07:00 WIB',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                DateFormat('EEEE, d MMM', 'id').format(now),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
