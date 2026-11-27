import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klock_app/features/attendance/presentation/widgets/photo_preview.dart';

void main() {
  testWidgets('Missing photo shows capture placeholder', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PhotoPreview())),
    );
    expect(find.text('Foto kehadiranmu'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });
}
