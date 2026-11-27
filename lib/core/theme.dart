import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

const mint = Color(0xFF6655D8);
const ink = Color(0xFF17213D);

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;

  final scheme = ColorScheme.fromSeed(
    seedColor: mint,
    brightness: brightness,
    primary: dark ? const Color(0xFFC3B8FF) : const Color(0xFF6552D7),
    surface: dark ? const Color(0xFF19213B) : const Color(0xFFF8F9FF),
    onSurface: dark ? const Color(0xFFF1F3FF) : ink,
  );

  final dmSans = GoogleFonts.dmSansTextTheme().apply(
    bodyColor: scheme.onSurface,
    displayColor: scheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Colors.transparent,

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

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface.withValues(alpha: dark ? .55 : .7),
      contentPadding: const EdgeInsets.all(18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: .5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: .4),
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
  );
}
