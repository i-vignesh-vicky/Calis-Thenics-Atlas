import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_radius.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData dark() {
    const scheme = AppColors.darkScheme;

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.black,
    );

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.black,
        indicatorColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        height: 64,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.amber, size: 24);
          }
          return const IconThemeData(color: AppColors.muted, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.amber,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            );
          }
          return const TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.amber, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: AppColors.muted),
        labelStyle: const TextStyle(color: AppColors.subtle),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.amber,
          foregroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.borderSubtle),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      // Hero / display sizes — Equinox-style large bold headlines
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        color: AppColors.white,
        height: 1.1,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
        color: AppColors.white,
        height: 1.15,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.white,
        height: 1.2,
      ),
      // Headlines
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: AppColors.white,
        height: 1.25,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: AppColors.white,
        height: 1.3,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.white,
        height: 1.35,
      ),
      // Titles
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.white,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.white,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: AppColors.white,
      ),
      // Body
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.white,
        height: 1.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.subtle,
        height: 1.5,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.muted,
        height: 1.4,
      ),
      // Labels — uppercase spaced (Open / Equinox category labels)
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: AppColors.subtle,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: AppColors.muted,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: AppColors.muted,
      ),
    );
  }

  static ThemeData light() => dark();
}
