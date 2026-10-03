import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OnboardingProgressBar extends StatelessWidget {
  const OnboardingProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = current / total;
    return SizedBox(
      height: 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final filled = constraints.maxWidth * progress;
          return Stack(
            children: [
              // Track
              Container(color: const Color(0xFF1E1E1E)),
              // Fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: filled,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.amber.withValues(alpha: 0.6),
                      AppColors.amber,
                    ],
                  ),
                ),
              ),
              // Glow dot at leading edge
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                left: (filled - 4).clamp(0, constraints.maxWidth - 4),
                top: -2,
                child: Container(
                  width: 8,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.amber,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.amber.withValues(alpha: 0.8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
