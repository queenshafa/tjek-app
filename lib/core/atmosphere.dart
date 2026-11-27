import 'package:material_ui/material_ui.dart';

class Atmosphere extends StatelessWidget {
  const Atmosphere({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      color: dark ? const Color(0xFF0C1328) : const Color(0xFFEEF1FC),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -130,
            right: -150,
            child: _glow(
              460,
              dark ? const Color(0xFF514785) : const Color(0xFFB9AEF7),
            ),
          ),
          Positioned(
            top: 300,
            left: -180,
            child: _glow(
              450,
              dark ? const Color(0xFF1C555E) : const Color(0xFF9FDDE0),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -90,
            child: _glow(
              360,
              dark ? const Color(0xFF4C365D) : const Color(0xFFF1C6BD),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: _Grain(dark))),
          ),
          child,
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) => IgnorePointer(
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: .65), color.withValues(alpha: 0)],
        ),
      ),
    ),
  );
}

class _Grain extends CustomPainter {
  _Grain(this.dark);
  final bool dark;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (dark ? Colors.white : const Color(0xFF516086)).withValues(
        alpha: .06,
      );
    for (double x = 12; x < size.width; x += 24) {
      for (double y = 12; y < size.height; y += 24) {
        canvas.drawCircle(Offset(x, y), .7, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _Grain old) => dark != old.dark;
}
