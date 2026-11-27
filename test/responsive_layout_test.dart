import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:klock_app/app.dart';
import 'package:klock_app/core/theme_provider.dart';
import 'package:klock_app/features/auth/auth_providers.dart';
import 'package:klock_app/features/attendance/presentation/providers.dart';
import 'package:klock_app/features/profile/profile_repository.dart';

import 'support/theme_fixture.dart';

void main() {
  for (final width in [320.0, 390.0]) {
    testWidgets('Pages fit ${width.toInt()}px with larger accessibility text', (
      tester,
    ) async {
      await initializeDateFormatting('id');
      tester.view.physicalSize = Size(width, 844);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            themeProvider.overrideWith(TestTheme.new),
            sessionProvider.overrideWith((ref) => Stream.value(true)),
            studentNameProvider.overrideWithValue('Alya Putri'),
            avatarProvider.overrideWith((ref) => Stream.value(null)),
            attendanceProvider.overrideWith((ref) => Stream.value([])),
          ],
          child: const KlockApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (final page in ['Riwayat', 'Profil']) {
        await tester.tap(find.text(page));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      await tester.pumpWidget(const SizedBox());
    });
  }
}
