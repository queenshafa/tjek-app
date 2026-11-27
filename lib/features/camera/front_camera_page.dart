import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:material_ui/material_ui.dart';

import 'camera_session.dart';

class FrontCameraPage extends StatefulWidget {
  const FrontCameraPage({super.key});
  @override
  State<FrontCameraPage> createState() => _FrontCameraPageState();
}

class _FrontCameraPageState extends State<FrontCameraPage> {
  final session = CameraSession();
  @override
  void initState() {
    super.initState();
    session.open();
  }

  @override
  void dispose() {
    session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: session,
    builder: (context, _) => PopScope(
      canPop: !session.busy,
      child: Scaffold(
        appBar: AppBar(title: const Text('Kamera depan')),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Posisikan wajahmu di tengah. Cari tempat yang cukup terang, ya.',
                ),
              ),
              Expanded(
                child: Center(
                  child: session.controller?.value.isInitialized == true
                      ? AspectRatio(
                          aspectRatio:
                              MediaQuery.orientationOf(context) ==
                                  Orientation.portrait
                              ? 1 / session.controller!.value.aspectRatio
                              : session.controller!.value.aspectRatio,
                          child: CameraPreview(session.controller!),
                        )
                      : session.error != null
                      ? Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            session.error!,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
              if (session.error != null && session.controller != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(session.error!),
                ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: session.error != null
                    ? OutlinedButton(
                        onPressed: session.open,
                        child: const Text('Coba lagi'),
                      )
                    : FilledButton.icon(
                        onPressed: session.busy || session.controller == null
                            ? null
                            : () async {
                                final Uint8List? bytes = await session.take();
                                if (context.mounted && bytes != null) {
                                  Navigator.pop(context, bytes);
                                }
                              },
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: Text(session.busy ? 'Sebentar…' : 'Ambil foto'),
                      ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
