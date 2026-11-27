import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/surface_card.dart';
import '../../auth/auth_providers.dart';
import 'profile_photo.dart';

class ProfileIdentity extends ConsumerWidget {
  const ProfileIdentity({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => SurfaceCard(
    child: Column(
      children: [
        const ProfilePhoto(),
        const SizedBox(height: 12),
        Text(
          ref.watch(studentNameProvider),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -.7,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.school_outlined,
                size: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 7),
              const Text('Akun siswi', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}
