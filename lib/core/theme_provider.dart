import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = AsyncNotifierProvider<ThemePreference, ThemeMode>(
  ThemePreference.new,
);

class ThemePreference extends AsyncNotifier<ThemeMode> {
  late final storage = SharedPreferencesAsync();
  @override
  Future<ThemeMode> build() async {
    final value = await storage.getString('theme');
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    await storage.setString('theme', mode.name);
    state = AsyncData(mode);
  }
}
