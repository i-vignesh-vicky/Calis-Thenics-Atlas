import 'dart:math' as math;

import 'package:flutter/material.dart';

class _Particle {
  _Particle(this.x, this.y, this.radius, this.speed, this.opacity, this.phase);

  final double x;
  double y;
  final double radius;
  final double speed;
  final double opacity;
  final double phase;
}

class ParticlePainter extends CustomPainter {
  ParticlePainter(this.animation) : super(repaint: animation) {
    final rng = math.Random(42);
    _particles = List.generate(22, (i) {
      return _Particle(
        rng.nextDouble(),
        rng.nextDouble(),
        1.2 + rng.nextDouble() * 2.4,
        0.04 + rng.nextDouble() * 0.08,
        0.08 + rng.nextDouble() * 0.22,
        rng.nextDouble() * math.pi * 2,
      );
    });
  }

  final Animation<double> animation;
  late final List<_Particle> _particles;

  static const _amber = Color(0xFF75020F);

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in _particles) {
      final drift = math.sin(p.phase + t * math.pi * 2) * 0.015;
      final yNorm = (p.y - p.speed * t * 3) % 1.0;
      final yPos = yNorm < 0 ? yNorm + 1.0 : yNorm;

      // Fade in near bottom, fade out near top
      final fadeOpacity = yPos < 0.1
          ? yPos / 0.1
          : yPos > 0.85
              ? (1.0 - yPos) / 0.15
              : 1.0;

      paint.color = _amber.withValues(alpha: p.opacity * fadeOpacity);
      canvas.drawCircle(
        Offset((p.x + drift) * size.width, yPos * size.height),
        p.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter old) => false;
}
