import 'package:material_ui/material_ui.dart';

class Atmosphere extends StatelessWidget {
  const Atmosphere({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      color: dark ? const Color(0xFF121214) : const Color(0xFFF5F5F5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: _Grain(dark))),
          ),
          child,
        ],
      ),
    );
  }
}

class _Grain extends CustomPainter {
  _Grain(this.dark);
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (dark ? Colors.white : Colors.black).withValues(
        alpha: dark ? 0.03 : 0.025,
      );
    for (double x = 12; x < size.width; x += 24) {
      for (double y = 12; y < size.height; y += 24) {
        canvas.drawCircle(Offset(x, y), 0.7, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _Grain old) => dark != old.dark;
}
