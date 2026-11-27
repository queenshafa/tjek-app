import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klock_app/core/theme_provider.dart';

class TestTheme extends ThemePreference {
  @override
  Future<ThemeMode> build() async => ThemeMode.light;
  @override
  Future<void> setMode(ThemeMode mode) async => state = AsyncData(mode);
}
