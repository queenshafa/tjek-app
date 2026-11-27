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
      orElse: () => ThemeMode.light, // Default selalu Light Mode
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    state = AsyncData(mode); // Langsung update UI seketika tanpa jeda
    await storage.setString('theme', mode.name);
  }
}
