import 'package:flutter/material.dart';

/// Atlas color palette and dark color scheme.
///
/// Raw palette constants are named after their visual value, not their role,
/// so they can be referenced in the [ColorScheme] below with semantic meaning.
abstract final class AppColors {
  // --- Raw palette ---
  static const Color black = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceElevated = Color(0xFF1E1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF9E9E9E);
  static const Color amber = Color(0xFFF5A623);
  static const Color error = Color(0xFFFF453A);
  static const Color success = Color(0xFF34C759);

  // --- Dark color scheme ---
  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    // Primary — amber accent
    primary: Color(0xFFF5A623),
    onPrimary: Color(0xFF1A0F00),
    primaryContainer: Color(0xFF3A2000),
    onPrimaryContainer: Color(0xFFFFD9A0),
    // Secondary — neutral dark
    secondary: Color(0xFF2C2C2C),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF1A1A1A),
    onSecondaryContainer: Color(0xFFE0E0E0),
    // Tertiary — success green (achievements, streaks)
    tertiary: Color(0xFF34C759),
    onTertiary: Color(0xFF0A0A0A),
    tertiaryContainer: Color(0xFF0A2A14),
    onTertiaryContainer: Color(0xFF9DFFC0),
    // Error
    error: Color(0xFFFF453A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFF3A0A08),
    onErrorContainer: Color(0xFFFFB4AB),
    // Surfaces
    surface: Color(0xFF141414),
    onSurface: Color(0xFFFFFFFF),
    onSurfaceVariant: Color(0xFF9E9E9E),
    // Borders
    outline: Color(0xFF2E2E2E),
    outlineVariant: Color(0xFF1C1C1C),
    // Misc
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFF0F0F0),
    onInverseSurface: Color(0xFF1A1A1A),
    inversePrimary: Color(0xFFB85C00),
    // Surface container levels (Material 3 elevation model)
    surfaceContainerLowest: Color(0xFF0A0A0A),
    surfaceContainerLow: Color(0xFF0F0F0F),
    surfaceContainer: Color(0xFF141414),
    surfaceContainerHigh: Color(0xFF1E1E1E),
    surfaceContainerHighest: Color(0xFF282828),
  );
}
