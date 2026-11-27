import 'package:material_ui/material_ui.dart';

class CaptureIntro extends StatelessWidget {
  const CaptureIntro({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Foto dulu, yuk.',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 10),
      Text(
        'Pastikan wajahmu terlihat jelas. Cek fotonya sebelum dikirim. '
        'Jam absen dihitung saat server menerima kirimanmu, bukan saat foto diambil.',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 24),
    ],
  );
}
