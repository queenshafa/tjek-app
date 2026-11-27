import 'package:material_ui/material_ui.dart';

import '../../core/surface_card.dart';
import '../../core/theme_picker.dart';
import '../../core/enter_motion.dart';
import 'widgets/profile_identity.dart';
import 'widgets/logout_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => EnterMotion(
    child: ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'Tentang kamu',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.8,
                ),
              ),
            ),
            ThemePicker(),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Biar lebih kenal, pasang foto terbaikmu.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 26),
        const ProfileIdentity(),
        const SizedBox(height: 20),
        SurfaceCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary
                      .withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.shield_outlined, size: 23),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fotomu, tetap privat.',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hanya untuk profil dan bukti absen. Butuh bantuan '
                      'akun atau mau hapus data? Hubungi admin sekolah, ya.',
                      style: TextStyle(fontSize: 12, height: 1.7),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const LogoutButton(),
        const SizedBox(height: 22),
        Center(
          child: Text(
            'klock  /  dibuat untuk hari sekolahmu',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    ),
  );
}
