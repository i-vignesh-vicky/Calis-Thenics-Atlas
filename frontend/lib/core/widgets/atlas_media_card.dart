import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../theme/app_colors.dart';

/// Full-bleed image card with text overlay — Equinox+ style.
///
/// When [imageWidget] is null, renders a solid [placeholderColor] background.
/// The [badge] (e.g. "PUSH" or "ON DEMAND") appears vertically on the left edge.
class AtlasMediaCard extends StatelessWidget {
  const AtlasMediaCard({
    super.key,
    required this.title,
    this.subtitle,
    this.badge,
    this.imageWidget,
    this.placeholderColor,
    this.onTap,
    this.width,
    this.height = 200,
    this.borderRadius,
  });

  final String title;
  final String? subtitle;
  final String? badge;
  final Widget? imageWidget;
  final Color? placeholderColor;
  final VoidCallback? onTap;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppRadius.lg);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: radius,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image or colour
              imageWidget ??
                  ColoredBox(
                    color: placeholderColor ?? AppColors.surfaceElevated,
                  ),
              // Bottom gradient for text legibility
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.4, 1.0],
                    colors: [Colors.transparent, Color(0xCC000000)],
                  ),
                ),
              ),
              // Vertical badge on left edge
              if (badge != null)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 22,
                    color: Colors.black26,
                    alignment: Alignment.center,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        badge!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: AppColors.subtle,
                        ),
                      ),
                    ),
                  ),
                ),
              // Bottom text
              Positioned(
                left: badge != null ? 30 : 14,
                right: 14,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (subtitle != null)
                      Text(
                        subtitle!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4,
                          color: AppColors.amber,
                        ),
                      ),
                    if (subtitle != null) const SizedBox(height: 2),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact category chip — outlined pill button for browse grids.
class AtlasCategoryChip extends StatelessWidget {
  const AtlasCategoryChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.amber : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: selected ? AppColors.amber : AppColors.borderSubtle,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
