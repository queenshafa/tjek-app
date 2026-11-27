import 'package:material_ui/material_ui.dart';

import '../../core/brand_header.dart';
import '../../core/orbit_clock.dart';
import '../../core/surface_card.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Header (seragam dengan Beranda)
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -.5,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Masuk dulu sebelum absen, ya.',
                    style: TextStyle(fontSize: 14, color: textColor),
                  ),
                ],
              ),
            ),
            const BrandHeader(),
          ],
        ),
        const SizedBox(height: 20),

        // Kartu Jam & Tagline (terinspirasi kartu jam Beranda)
        SurfaceCard(
          padding: 20,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Absen dulu.\nBaru cerita.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Satu foto, langsung beres.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const OrbitClock(size: 76),
            ],
          ),
        ),
      ],
    );
  }
}
