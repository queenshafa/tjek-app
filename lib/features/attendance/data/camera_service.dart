import 'dart:typed_data';

import 'package:material_ui/material_ui.dart';

import '../../camera/front_camera_page.dart';

abstract final class CameraService {
  static Future<Uint8List?> capture(BuildContext context) async {
    final consent = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pakai kamera depan, ya?'),
        content: const Text(
          'Klock perlu akses kamera untuk foto wajahmu. Foto baru dikirim '
          'setelah kamu menekan tombol simpan. Tidak ada akses ke galeri atau mikrofon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Nanti dulu'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );
    if (consent != true || !context.mounted) return null;
    return Navigator.push<Uint8List>(
      context,
      MaterialPageRoute(builder: (_) => const FrontCameraPage()),
    );
  }
}
