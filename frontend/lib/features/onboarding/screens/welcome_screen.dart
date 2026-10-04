import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/onboarding_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/particle_painter.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
    this.isAuthenticated = false,
    required this.onboardingStorage,
  });

  final bool isAuthenticated;
  final OnboardingStorage onboardingStorage;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // Particle loop — runs forever
  late final AnimationController _particles;

  // Main sequence — 4200ms total
  late final AnimationController _seq;

  // Per-letter animations (C A L I S)
  static const _letters = ['C', 'A', 'L', 'I', 'S'];
  static const _staggerMs = 90.0;
  static const _letterDurMs = 550.0;
  static const _seqDurMs = 4200.0;

  late final List<Animation<double>> _letterOpacity;
  late final List<Animation<double>> _letterY;
  late final List<Animation<double>> _letterBlur;

  // Subtitle "THENICS ATLAS"
  late final Animation<double> _subtitleOpacity;
  late final Animation<double> _subtitleY;

  // Tagline words
  static const _taglineWords = ['Master', 'the', 'art', 'of', 'your', 'own', 'body.'];
  late final List<Animation<double>> _wordOpacity;

  // Bottom hairline pulse
  late final Animation<double> _hairlineWidth;

  bool _navigated = false;
  bool? _onboardingCompleted; // null while loading

  @override
  void initState() {
    super.initState();
    widget.onboardingStorage.isCompleted().then((done) {
      if (mounted) setState(() => _onboardingCompleted = done);
    });

    _particles = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _seq = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    );

    // Letters: C starts at 150ms, each +90ms, each lasts 550ms
    _letterOpacity = List.generate(_letters.length, (i) {
      final start = (150 + i * _staggerMs) / _seqDurMs;
      final end = (150 + i * _staggerMs + _letterDurMs) / _seqDurMs;
      return CurvedAnimation(
        parent: _seq,
        curve: Interval(start, end.clamp(0, 1), curve: Curves.easeOut),
      );
    });

    _letterY = List.generate(_letters.length, (i) {
      final start = (150 + i * _staggerMs) / _seqDurMs;
      final end = (150 + i * _staggerMs + _letterDurMs * 0.6) / _seqDurMs;
      return CurvedAnimation(
        parent: _seq,
        curve: Interval(start, end.clamp(0, 1), curve: Curves.easeOutCubic),
      );
    });

    _letterBlur = List.generate(_letters.length, (i) {
      final start = (150 + i * _staggerMs) / _seqDurMs;
      final end = (150 + i * _staggerMs + _letterDurMs * 0.7) / _seqDurMs;
      return CurvedAnimation(
        parent: _seq,
        curve: Interval(start, end.clamp(0, 1), curve: Curves.easeOut),
      );
    });

    // Subtitle: starts after last letter finishes ~1150ms
    const subtitleStartMs = 1150.0;
    const subtitleDurMs = 600.0;
    _subtitleOpacity = CurvedAnimation(
      parent: _seq,
      curve: const Interval(
        subtitleStartMs / _seqDurMs,
        (subtitleStartMs + subtitleDurMs) / _seqDurMs,
        curve: Curves.easeOut,
      ),
    );
    _subtitleY = CurvedAnimation(
      parent: _seq,
      curve: const Interval(
        subtitleStartMs / _seqDurMs,
        (subtitleStartMs + subtitleDurMs * 0.7) / _seqDurMs,
        curve: Curves.easeOutCubic,
      ),
    );

    // Tagline words: 1700ms, each word +100ms apart, each 500ms duration
    const taglineStartMs = 1700.0;
    const wordStaggerMs = 90.0;
    const wordDurMs = 500.0;
    _wordOpacity = List.generate(_taglineWords.length, (i) {
      final start = (taglineStartMs + i * wordStaggerMs) / _seqDurMs;
      final end = (taglineStartMs + i * wordStaggerMs + wordDurMs) / _seqDurMs;
      return CurvedAnimation(
        parent: _seq,
        curve: Interval(start, end.clamp(0, 1), curve: Curves.easeOut),
      );
    });

    // Hairline: starts at 2600ms
    _hairlineWidth = CurvedAnimation(
      parent: _seq,
      curve: const Interval(2600 / _seqDurMs, 3200 / _seqDurMs, curve: Curves.easeOutCubic),
    );

    _seq.forward();

    // Auto-navigate at 3800ms
    Future.delayed(const Duration(milliseconds: 3800), _navigateNext);
  }

  @override
  void dispose() {
    _particles.dispose();
    _seq.dispose();
    super.dispose();
  }

  void _navigateNext() {
    if (!mounted || _navigated) return;
    // Wait for the onboarding flag to load (it's fast — storage read completes well before 3.8s)
    final done = _onboardingCompleted ?? false;
    _navigated = true;
    if (!done) {
      context.go('/onboarding');
    } else if (widget.isAuthenticated) {
      context.go('/home');
    } else {
      context.go('/auth/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: _navigateNext,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            // Ambient particles
            AnimatedBuilder(
              animation: _particles,
              builder: (_, __) => CustomPaint(
                painter: ParticlePainter(_particles),
                size: size,
              ),
            ),

            // Radial amber glow in center
            Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.amber.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  // "CALIS" — animated letter-by-letter
                  AnimatedBuilder(
                    animation: _seq,
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          ..._letters.asMap().entries.map((e) {
                            final i = e.key;
                            final letter = e.value;
                            final opacity = _letterOpacity[i].value;
                            final yOffset = (1.0 - _letterY[i].value) * 28.0;
                            final blur = (1.0 - _letterBlur[i].value) * 10.0;
                            return Transform.translate(
                              offset: Offset(0, yOffset),
                              child: Opacity(
                                opacity: opacity,
                                child: ImageFiltered(
                                  imageFilter: ui.ImageFilter.blur(
                                    sigmaX: blur,
                                    sigmaY: blur,
                                  ),
                                  child: Text(
                                    letter,
                                    style: TextStyle(
                                      fontSize: 72,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 10,
                                      // Last letter in amber
                                      color: i == _letters.length - 1
                                          ? AppColors.amber
                                          : AppColors.white,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 4),

                  // Subtitle "THENICS ATLAS"
                  AnimatedBuilder(
                    animation: _seq,
                    builder: (_, __) => Transform.translate(
                      offset: Offset(0, (1.0 - _subtitleY.value) * 12),
                      child: Opacity(
                        opacity: _subtitleOpacity.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'THENICS',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 8,
                                color: AppColors.white.withValues(alpha: 0.4),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.amber,
                              ),
                            ),
                            Text(
                              'ATLAS',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 8,
                                color: AppColors.white.withValues(alpha: 0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Tagline — word by word
                  AnimatedBuilder(
                    animation: _seq,
                    builder: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 6,
                        children: _taglineWords.asMap().entries.map((e) {
                          return Opacity(
                            opacity: _wordOpacity[e.key].value,
                            child: Text(
                              e.value,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.5,
                                color: AppColors.white.withValues(alpha: 0.55),
                                height: 1.6,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Amber hairline pulse
                  AnimatedBuilder(
                    animation: _seq,
                    builder: (_, __) {
                      return Column(
                        children: [
                          // Hairline
                          Center(
                            child: SizedBox(
                              width: _hairlineWidth.value * 48,
                              height: 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      AppColors.amber.withValues(alpha: 0.6),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Opacity(
                            opacity: _hairlineWidth.value,
                            child: Text(
                              'Tap to continue',
                              style: TextStyle(
                                fontSize: 11,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white.withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
