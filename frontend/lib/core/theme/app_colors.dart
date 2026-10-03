import 'package:flutter/material.dart';

abstract final class AppColors {
  // --- Raw palette ---
  static const Color black = Color(0xFF19171B);
  static const Color surface = Color(0xFF1D1A1E);
  static const Color surfaceElevated = Color(0xFF231F24);
  static const Color surfaceHighest = Color(0xFF2C2830);
  static const Color white = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF666666);
  static const Color subtle = Color(0xFF9E9E9E);
  static const Color border = Color(0xFF2B2029);
  static const Color borderSubtle = Color(0xFF322730);

  // Accent — crimson red (CTA, active nav)
  static const Color amber = Color(0xFF75020F);
  // Accent — teal (progress, completion, streaks)
  static const Color teal = Color(0xFF00C896);

  static const Color error = Color(0xFFFF453A);
  static const Color success = Color(0xFF34C759);

  // --- Dark color scheme ---
  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    // Primary — crimson red accent
    primary: Color(0xFF75020F),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF51080D),
    onPrimaryContainer: Color(0xFFFFCDD2),
    // Secondary — teal (progress / completion)
    secondary: Color(0xFF00C896),
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFF003D2D),
    onSecondaryContainer: Color(0xFF9DFCE0),
    // Tertiary — muted surface
    tertiary: Color(0xFF2C2830),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFF231F24),
    onTertiaryContainer: Color(0xFFE0E0E0),
    // Error
    error: Color(0xFFFF453A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFF3A0A08),
    onErrorContainer: Color(0xFFFFB4AB),
    // Surfaces — dark purple-black base
    surface: Color(0xFF1D1A1E),
    onSurface: Color(0xFFFFFFFF),
    onSurfaceVariant: Color(0xFF9E9E9E),
    // Borders
    outline: Color(0xFF322730),
    outlineVariant: Color(0xFF2B2029),
    // Misc
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFF0F0F0),
    onInverseSurface: Color(0xFF19171B),
    inversePrimary: Color(0xFFB71C2F),
    // Surface container levels
    surfaceContainerLowest: Color(0xFF19171B),
    surfaceContainerLow: Color(0xFF1D1A1E),
    surfaceContainer: Color(0xFF211E22),
    surfaceContainerHigh: Color(0xFF231F24),
    surfaceContainerHighest: Color(0xFF2C2830),
  );
}
