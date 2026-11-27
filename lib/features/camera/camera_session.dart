import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:material_ui/material_ui.dart';

import 'photo_codec.dart';
import 'front_lens.dart';

class CameraSession extends ChangeNotifier with WidgetsBindingObserver {
  CameraController? controller;
  String? error;
  bool busy = false, _opening = false, _closed = false, _active = true;
  CameraSession() {
    WidgetsBinding.instance.addObserver(this);
  }
  Future<void> open() async {
    if (_opening || _closed || !_active) return;
    if (controller != null) {
      error = null;
      notifyListeners();
      return;
    }
    _opening = true;
    error = null;
    notifyListeners();
    CameraController? next;
    try {
      final cameras = await availableCameras();
      if (_closed || !_active) return;
      next = CameraController(
        FrontLens.select(cameras),
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await next.initialize(); // OS asks for camera permission before preview is shown.
      if (_closed || !_active) {
        await next.dispose();
        return;
      }
      controller = next;
    } on CameraException catch (e) {
      await next?.dispose();
      error = e.code.contains('Access')
          ? 'Kamera belum diizinkan. Buka Pengaturan HP → Klock App → izinkan Kamera, lalu coba lagi.'
          : 'Kamera belum bisa dibuka. Coba lagi, ya.';
    } catch (e) {
      await next?.dispose();
      error = e is StateError
          ? e.message.toString()
          : 'Kamera bermasalah. Coba lagi.';
    } finally {
      _opening = false;
      if (!_closed) {
        notifyListeners();
        if (_active && controller == null && error == null) open();
      }
    }
  }

  Future<Uint8List?> take() async {
    final camera = controller;
    if (busy || camera == null || !camera.value.isInitialized) return null;
    busy = true;
    notifyListeners();
    try {
      final file = await camera.takePicture();
      return await PhotoCodec.compress(await file.readAsBytes());
    } catch (_) {
      error = 'Fotonya belum tersimpan. Coba ambil lagi, ya.';
      return null;
    } finally {
      busy = false;
      if (!_closed) notifyListeners();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _active = state == AppLifecycleState.resumed;
    if (!_active) {
      final old = controller;
      controller = null;
      old?.dispose();
    } else if (!_opening) {
      open();
    }
    if (!_closed) notifyListeners();
  }

  @override
  void dispose() {
    _closed = true;
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }
}
