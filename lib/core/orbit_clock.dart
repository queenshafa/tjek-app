import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

class OrbitClock extends StatelessWidget {
  const OrbitClock({super.key, this.size = 120});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CustomPaint(painter: _ClockArt(Theme.of(context).colorScheme)),
  );
}

class _ClockArt extends CustomPainter {
  _ClockArt(this.scheme);
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero), r = size.width * .36;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = scheme.primary.withValues(alpha: .25);
    canvas.drawCircle(c, r * 1.27, stroke);
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r * 1.08),
      -1.2,
      4.8,
      false,
      stroke,
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(
          colors: [
            scheme.surface.withValues(alpha: .9),
            scheme.primaryContainer.withValues(alpha: .55),
          ],
        ).createShader(Rect.fromCircle(center: c, radius: r)),
    );
    canvas.drawCircle(
      c,
      r,
      stroke..color = Colors.white.withValues(alpha: .65),
    );
    for (var i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final point = c + Offset(math.sin(angle), -math.cos(angle)) * r * .78;
      canvas.drawCircle(
        point,
        i % 3 == 0 ? 2 : 1,
        Paint()..color = scheme.primary.withValues(alpha: .65),
      );
    }
    final hand = Paint()
      ..color = scheme.primary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(c, c + Offset(0, -r * .46), hand);
    canvas.drawLine(c, c + Offset(r * .35, r * .2), hand);
    canvas.drawCircle(c, 3.4, Paint()..color = scheme.primary);
    canvas.drawCircle(
      c + Offset(r * .98, -r * .8),
      5,
      Paint()..color = const Color(0xFFF6B38E),
    );
    final badge = c + Offset(r * .8, r * .8);
    canvas.drawCircle(badge, r * .31, Paint()..color = const Color(0xFF90DCCB));
    canvas.drawPath(
      Path()
        ..moveTo(badge.dx - 6, badge.dy)
        ..lineTo(badge.dx - 1, badge.dy + 5)
        ..lineTo(badge.dx + 7, badge.dy - 5),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round
        ..color = const Color(0xFF164E49),
    );
  }

  @override
  bool shouldRepaint(covariant _ClockArt old) => old.scheme != scheme;
}
