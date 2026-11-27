import 'dart:typed_data';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/camera_service.dart';

import 'providers.dart';
import 'widgets/photo_preview.dart';
import 'widgets/capture_intro.dart';

class CapturePage extends ConsumerStatefulWidget {
  const CapturePage({super.key});
  @override
  ConsumerState<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends ConsumerState<CapturePage> {
  Uint8List? photo;
  bool busy = false;
  String? error;
  Future<void> capture() async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      final bytes = await CameraService.capture(context);
      if (bytes == null) return;
      if (mounted) setState(() => photo = bytes);
    } catch (_) {
      if (mounted) {
        setState(
          () => error = 'Kamera gagal atau foto melebihi 100 KB. Periksa izin kamera dan coba lagi.',
        );
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> submit() async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await ref.read(repositoryProvider).submit(photo!);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sudah masuk! Absensimu tersimpan.')),
      );
    } catch (_) {
      if (mounted) {
        setState(
          () => error = 'Gagal menyimpan. Periksa koneksi; pastikan kamu belum absen hari ini.',
        );
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !busy,
    child: Scaffold(
      appBar: AppBar(title: const Text('Catat kehadiran')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const CaptureIntro(),
            PhotoPreview(photo: photo),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: busy ? null : capture,
              icon: const Icon(Icons.camera_alt_outlined),
              label: Text(photo == null ? 'Buka kamera' : 'Ambil ulang'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: busy || photo == null ? null : submit,
              child: Text(busy ? 'Memproses…' : 'Kirim kehadiran'),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  error!,
                  style: const TextStyle(color: Colors.orangeAccent),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
