import 'dart:ui';

import 'package:material_ui/material_ui.dart';

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = 22,
    this.tint,
  });
  final Widget child;
  final double padding;
  final Color? tint;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D2254).withValues(alpha: dark ? .18 : .06),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (tint ?? (dark ? const Color(0xFF475077) : Colors.white))
                      .withValues(alpha: dark ? .38 : .75),
                  (dark ? const Color(0xFF232D4A) : Colors.white).withValues(
                    alpha: dark ? .28 : .38,
                  ),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: dark ? .14 : .8),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
