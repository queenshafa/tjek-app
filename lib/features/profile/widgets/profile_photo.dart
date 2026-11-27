import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../attendance/data/camera_service.dart';
import '../profile_repository.dart';

class ProfilePhoto extends ConsumerStatefulWidget {
  const ProfilePhoto({super.key});
  @override
  ConsumerState<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends ConsumerState<ProfilePhoto> {
  bool busy = false;
  Future<void> change() async {
    setState(() => busy = true);
    try {
      final photo = await CameraService.capture(context);
      if (photo == null || !mounted) return;
      final save = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pakai foto ini?'),
          content: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(photo),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Simpan'),
            ),
          ],
        ),
      );
      if (save != true || !mounted) return;
      await ref.read(profileRepositoryProvider).save(photo);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Foto profil belum tersimpan. Cek koneksi, lalu coba lagi.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(avatarProvider);
    final bytes = avatar.asData?.value;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: .65),
                const Color(0xFF8BD8CA),
                const Color(0xFFF2C3B4),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary
                    .withValues(alpha: .18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 46,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            backgroundImage: bytes == null ? null : MemoryImage(bytes),
            child: bytes == null
                ? const Icon(Icons.person_outline, size: 42)
                : null,
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: busy || avatar.isLoading ? null : change,
          icon: const Icon(Icons.camera_alt_outlined, size: 18),
          label: Text(busy ? 'Menyimpan…' : 'Ganti foto'),
        ),
        if (avatar.hasError)
          TextButton(
            onPressed: () => ref.invalidate(avatarProvider),
            child: const Text('Foto gagal dimuat · Coba lagi'),
          ),
      ],
    );
  }
}
