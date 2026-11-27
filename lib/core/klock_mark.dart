import 'package:material_ui/material_ui.dart';

class KlockMark extends StatelessWidget {
  const KlockMark({super.key, this.size = 46});
  final double size;
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(size * .25),
    child: Image.asset(
      'assets/brand/klock.png',
      width: size,
      height: size,
      semanticLabel: 'Klock',
    ),
  );
}
