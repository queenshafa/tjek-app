import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/enter_motion.dart';
import '../../../core/surface_card.dart';
import 'camera_session.dart';

class FrontCameraPage extends StatefulWidget {
  const FrontCameraPage({super.key});
  @override
  State<FrontCameraPage> createState() => _FrontCameraPageState();
}

class _FrontCameraPageState extends State<FrontCameraPage> {
  final session = CameraSession();
  static const _orange = Color(0xFFED7014);

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
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => PopScope(
        canPop: !session.busy,
        child: Scaffold(
          backgroundColor: isDark
              ? Theme.of(context).scaffoldBackgroundColor
              : const Color(0xFFF5F5F5),
          body: EnterMotion(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header (seragam dengan halaman lain)
                    Row(
                      children: [
                        Material(
                          color: isDark
                              ? const Color(0xFF1E1E22)
                              : Colors.white,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: session.busy
                                ? null
                                : () => Navigator.maybePop(context),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.08)
                                      : Colors.black.withValues(alpha: 0.06),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 20,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kamera Depan',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Pastikan wajahmu terlihat jelas, ya.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Kartu Instruksi
                    SurfaceCard(
                      padding: 14,
                      radius: 18,
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: _orange.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.wb_sunny_outlined,
                              color: _orange,
                              size: 19,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Posisikan wajahmu di tengah dan cari tempat yang cukup terang.',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Viewfinder Kamera
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B0B0B),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.08),
                            width: 1.5,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (session.controller?.value.isInitialized == true)
                              ClipRect(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: session
                                        .controller!
                                        .value
                                        .previewSize!
                                        .height,
                                    height: session
                                        .controller!
                                        .value
                                        .previewSize!
                                        .width,
                                    child: CameraPreview(session.controller!),
                                  ),
                                ),
                              )
                            else if (session.error != null)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.videocam_off_outlined,
                                        color: _orange,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        session.error!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              const Center(
                                child: CircularProgressIndicator(
                                  color: _orange,
                                ),
                              ),

                            // Bingkai sudut halus di atas preview kamera
                            if (session.controller?.value.isInitialized == true)
                              IgnorePointer(
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.25,
                                      ),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    if (session.error != null && session.controller != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          session.error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFD50000),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Tombol Aksi Bawah (Oranye / Hitam sesuai gaya halaman lain)
                    if (session.error != null)
                      Material(
                        color: const Color(0xFF0B0B0B),
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          onTap: session.open,
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Coba lagi',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    color: _orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.refresh_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Material(
                        color: (session.busy || session.controller == null)
                            ? _orange.withValues(alpha: 0.65)
                            : _orange,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          onTap: session.busy || session.controller == null
                              ? null
                              : () async {
                                  final Uint8List? bytes = await session.take();
                                  if (context.mounted && bytes != null) {
                                    Navigator.pop(context, bytes);
                                  }
                                },
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    session.busy ? 'Sebentar…' : 'Ambil foto',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: session.busy
                                      ? const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
