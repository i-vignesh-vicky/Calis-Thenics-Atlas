import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Common layout wrapper for each onboarding step.
/// Provides: staggered label+headline reveal, subtext, scrollable content area.
class StepShell extends StatefulWidget {
  const StepShell({
    super.key,
    required this.headline,
    required this.child,
    this.subtext,
    this.scrollable = false,
  });

  final String headline;
  final String? subtext;
  final Widget child;
  final bool scrollable;

  @override
  State<StepShell> createState() => _StepShellState();
}

class _StepShellState extends State<StepShell>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _headlineSlide;
  late Animation<double> _headlineOpacity;
  late Animation<double> _contentOpacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _headlineSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.1, 0.6, curve: Curves.easeOutCubic),
    ));

    _headlineOpacity = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.1, 0.55, curve: Curves.easeOut),
    );

    _contentOpacity = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
    );

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inner = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Headline
          SlideTransition(
            position: _headlineSlide,
            child: FadeTransition(
              opacity: _headlineOpacity,
              child: Text(
                widget.headline,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  height: 1.15,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ),

          if (widget.subtext != null) ...[
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _headlineOpacity,
              child: Text(
                widget.subtext!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withValues(alpha: 0.4),
                  height: 1.5,
                ),
              ),
            ),
          ],

          const SizedBox(height: 32),

          // Step content
          FadeTransition(
            opacity: _contentOpacity,
            child: widget.child,
          ),
        ],
      ),
    );

    if (widget.scrollable) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: inner,
      );
    }
    return inner;
  }
}
