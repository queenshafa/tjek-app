import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klock_app/features/auth/login_fields.dart';
import 'package:klock_app/features/profile/widgets/logout_button.dart';
import 'package:klock_app/features/attendance/data/camera_service.dart';

void main() {
  testWidgets('Eye toggles password visibility without changing its value', (
    tester,
  ) async {
    final email = TextEditingController(),
        password = TextEditingController(text: 'sandi123');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginFields(email: email, password: password),
        ),
      ),
    );
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isTrue,
    );
    await tester.tap(find.byTooltip('Lihat kata sandi'));
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isFalse,
    );
    expect(password.text, 'sandi123');
    await tester.tap(find.byTooltip('Sembunyikan kata sandi'));
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField).last).obscureText,
      isTrue,
    );
    await tester.pumpWidget(const SizedBox());
    email.dispose();
    password.dispose();
  });
  testWidgets(
    'Cancelling logout keeps current screen without calling Firebase',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LogoutButton())),
      );
      await tester.tap(find.text('Keluar akun'));
      await tester.pumpAndSettle();
      expect(find.text('Mau keluar akun?'), findsOneWidget);
      await tester.tap(find.text('Batal'));
      await tester.pumpAndSettle();
      expect(find.text('Mau keluar akun?'), findsNothing);
      expect(find.text('Keluar akun'), findsOneWidget);
    },
  );
  testWidgets('Cancelling consent never opens a camera or gallery', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => CameraService.capture(context),
              child: const Text('Foto'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Foto'));
    await tester.pumpAndSettle();
    expect(find.text('Pakai kamera depan, ya?'), findsOneWidget);
    await tester.tap(find.text('Nanti dulu'));
    await tester.pumpAndSettle();
    expect(find.text('Kamera depan'), findsNothing);
    expect(find.text('Foto'), findsOneWidget);
  });
}
