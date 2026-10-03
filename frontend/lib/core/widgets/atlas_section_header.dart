import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Uppercase spaced section label with an optional "SEE ALL →" trailing action.
/// Matches the Equinox+ / Open app section header pattern.
class AtlasSectionHeader extends StatelessWidget {
  const AtlasSectionHeader({
    super.key,
    required this.label,
    this.onSeeAll,
  });

  final String label;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: AppColors.subtle,
          ),
        ),
        if (onSeeAll != null) ...[
          const Spacer(),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'SEE ALL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppColors.amber,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
