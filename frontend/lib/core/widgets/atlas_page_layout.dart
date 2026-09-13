import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// Standard page layout for all feature screens inside the main shell.
///
/// Provides a Scaffold with optional AppBar, consistent horizontal padding,
/// and safe-area handling. Feature screens should use this instead of raw
/// Scaffold to keep layout consistent.
class AtlasPageLayout extends StatelessWidget {
  const AtlasPageLayout({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.horizontalPadding = AppSpacing.md,
    this.applyTopSafeArea = false,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final double horizontalPadding;

  /// When the screen has no AppBar, set to true to inset content below status bar.
  final bool applyTopSafeArea;

  @override
  Widget build(BuildContext context) {
    final hasAppBar = title != null;
    return Scaffold(
      appBar: hasAppBar
          ? AppBar(
              title: Text(title!),
              actions: actions,
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        top: !hasAppBar && applyTopSafeArea,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: body,
        ),
      ),
    );
  }
}
