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
  bool showEditButton = false;

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
      if (mounted) {
        setState(() => showEditButton = false);
      }
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
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (!busy) {
              setState(() => showEditButton = !showEditButton);
            }
          },
          child: CircleAvatar(
            radius: 52,
            backgroundColor: const Color(0xFFD9D9D9),
            backgroundImage: bytes == null ? null : MemoryImage(bytes),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: showEditButton || busy
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: busy || avatar.isLoading ? null : change,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            busy ? Icons.hourglass_top_rounded : Icons.edit,
                            size: 13,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            busy ? 'Menyimpan…' : 'Edit foto',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        if (avatar.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: TextButton(
              onPressed: () => ref.invalidate(avatarProvider),
              child: const Text(
                'Foto gagal dimuat · Coba lagi',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
