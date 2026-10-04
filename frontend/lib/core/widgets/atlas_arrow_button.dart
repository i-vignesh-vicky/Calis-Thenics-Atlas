import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

/// Circular amber arrow button that morphs into a loading oval on tap,
/// then calls [onPressed] after the animation completes.
class AtlasArrowButton extends StatefulWidget {
  const AtlasArrowButton({
    super.key,
    required this.onPressed,
    this.enabled = true,
    this.size = 56.0,
  });

  final VoidCallback onPressed;
  final bool enabled;
  final double size;

  @override
  State<AtlasArrowButton> createState() => _AtlasArrowButtonState();
}

class _AtlasArrowButtonState extends State<AtlasArrowButton>
    with TickerProviderStateMixin {
  // Morph: circle → oval
  late final AnimationController _morphCtrl;
  late final Animation<double> _widthFactor; // 1.0 = circle, 1.9 = oval
  late final Animation<double> _arrowOpacity;

  // Bounce dots
  late final AnimationController _dotsCtrl;

  bool _animating = false;

  static const _morphDuration = Duration(milliseconds: 220);
  static const _holdDuration = Duration(milliseconds: 620);

  @override
  void initState() {
    super.initState();

    _morphCtrl = AnimationController(vsync: this, duration: _morphDuration);
    _widthFactor = CurvedAnimation(parent: _morphCtrl, curve: Curves.easeOutCubic);
    _arrowOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _morphCtrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _dotsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _morphCtrl.dispose();
    _dotsCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_animating || !widget.enabled) return;
    _animating = true;
    HapticFeedback.lightImpact();

    // Phase 1: arrow fades, circle expands to oval
    await _morphCtrl.forward();

    // Phase 2: bouncing dots loop
    _dotsCtrl.repeat();

    // Hold while dots animate
    await Future.delayed(_holdDuration);

    if (!mounted) return;
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final diameter = widget.size;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_morphCtrl, _dotsCtrl]),
        builder: (_, __) {
          final ovalWidth = diameter + (_widthFactor.value * (diameter * 0.95));
          final active = widget.enabled && !_animating;

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: active || _animating ? 1.0 : 0.35,
            child: Container(
              width: ovalWidth,
              height: diameter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(diameter / 2),
                color: AppColors.amber,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.amber.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Arrow icon — fades out during morph
                  Opacity(
                    opacity: _arrowOpacity.value,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: const Color(0xFFFFFFFF),
                      size: diameter * 0.42,
                    ),
                  ),

                  // Bouncing dots — fade in after morph
                  Opacity(
                    opacity: 1.0 - _arrowOpacity.value,
                    child: _BouncingDots(
                      controller: _dotsCtrl,
                      dotColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BouncingDots extends StatelessWidget {
  const _BouncingDots({required this.controller, required this.dotColor});

  final AnimationController controller;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final delay = i / 3.0;
        final offsetAnim = TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 0, end: -8).chain(
              CurveTween(curve: Curves.easeOut),
            ),
            weight: 40,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: -8, end: 0).chain(
              CurveTween(curve: Curves.bounceOut),
            ),
            weight: 60,
          ),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              delay,
              (delay + 0.67).clamp(0.0, 1.0),
              curve: Curves.linear,
            ),
          ),
        );

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: i == 1 ? 3 : 0),
          child: AnimatedBuilder(
            animation: offsetAnim,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, offsetAnim.value),
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

