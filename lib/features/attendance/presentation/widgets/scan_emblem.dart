import 'package:material_ui/material_ui.dart';

class ScanEmblem extends StatelessWidget {
  const ScanEmblem({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: 96,
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withValues(alpha: .18),
                  color.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withValues(alpha: .2)),
              color: Theme.of(context).colorScheme.surface
                  .withValues(alpha: .5),
            ),
            child: Icon(
              Icons.face_retouching_natural_rounded,
              size: 30,
              color: color,
            ),
          ),
          Positioned(
            right: 6,
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF9BE0D1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 17,
                color: Color(0xFF175C51),
              ),
            ),
          ),
          Positioned(
            left: 2,
            top: 12,
            child: Icon(
              Icons.add_rounded,
              size: 15,
              color: color.withValues(alpha: .5),
            ),
          ),
        ],
      ),
    );
  }
}
