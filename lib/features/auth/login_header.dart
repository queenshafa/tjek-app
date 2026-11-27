import 'package:material_ui/material_ui.dart';

import '../../core/brand_header.dart';
import '../../core/orbit_clock.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const BrandHeader(),
      const SizedBox(height: 20),
      const Center(child: OrbitClock(size: 140)),
      const SizedBox(height: 14),
      const Text(
        'Absen dulu.\nBaru mulai cerita.',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          height: 1.12,
          letterSpacing: -1.5,
        ),
      ),
      const SizedBox(height: 14),
      Text(
        'Satu foto, beres. Masuk pakai akun sekolahmu, ya.',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 24),
    ],
  );
}
