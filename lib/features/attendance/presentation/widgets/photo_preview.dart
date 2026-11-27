import 'dart:typed_data';

import 'package:material_ui/material_ui.dart';

import '../../../../core/surface_card.dart';

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({super.key, this.photo});
  final Uint8List? photo;
  @override
  Widget build(BuildContext context) => SurfaceCard(
    padding: 8,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: photo != null
            ? Image.memory(photo!, fit: BoxFit.cover)
            : Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.face_outlined, size: 72),
                    SizedBox(height: 18),
                    Text('Foto kehadiranmu'),
                  ],
                ),
              ),
      ),
    ),
  );
}
