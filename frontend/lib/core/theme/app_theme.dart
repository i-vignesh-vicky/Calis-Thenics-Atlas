import 'package:flutter/material.dart';

/// Placeholder theme — Week 02 will replace this with the full design system.
abstract final class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    );
  }
}
