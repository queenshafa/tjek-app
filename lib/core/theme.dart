import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

const brandOrange = Color(0xFFED7014);

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;

  final scheme = ColorScheme.fromSeed(
    seedColor: brandOrange,
    brightness: brightness,
    primary: brandOrange,
    onPrimary: Colors.white,
    surface: dark ? const Color(0xFF1E1E22) : Colors.white,
    onSurface: dark ? const Color(0xFFF4F4F6) : const Color(0xFF111111),
    onSurfaceVariant: dark ? const Color(0xFF9E9EA4) : const Color(0xFF6E6E73),
    outlineVariant: dark ? const Color(0xFF2E2E34) : const Color(0xFFE5E5EA),
  );

  final dmSans = GoogleFonts.dmSansTextTheme().apply(
    bodyColor: scheme.onSurface,
    displayColor: scheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    // Latar belakang solid (tidak transparan lagi)
    scaffoldBackgroundColor: dark
        ? const Color(0xFF121214)
        : const Color(0xFFF5F5F5),
    cardColor: scheme.surface,

    // Global font: DM Sans
    textTheme: dmSans.copyWith(
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        height: 1.5,
        color: scheme.onSurface,
      ),
      titleLarge: GoogleFonts.dmSans(
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: dark ? const Color(0xFF26262B) : Colors.white,
      contentPadding: const EdgeInsets.all(18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: brandOrange, width: 1.5),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: brandOrange,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.onSurface,
        minimumSize: const Size(double.infinity, 52),
        side: BorderSide(color: scheme.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
  );
}
