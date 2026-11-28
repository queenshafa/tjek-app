import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klock_app/app.dart';
import 'package:klock_app/core/theme_provider.dart';
import 'package:klock_app/features/auth/auth_providers.dart';

import 'support/theme_fixture.dart';

void main() {
  testWidgets('Theme pill changes full login from light to dark and back', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themeProvider.overrideWith(TestTheme.new),
          sessionProvider.overrideWith((ref) => Stream.value(false)),
        ],
        child: const TjekApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
    await tester.tap(find.byTooltip('Gelap'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    final context = tester.element(find.text('Masuk →'));
    expect(Theme.of(context).brightness, Brightness.dark);
    await tester.tap(find.byTooltip('Terang'));
    await tester.pumpAndSettle();
    expect(Theme.of(context).brightness, Brightness.light);
  });
}
