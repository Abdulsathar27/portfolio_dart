import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/providers/mouse_provider.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  final int _particleCount = 50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (_particles.isNotEmpty) return;

    for (int i = 0; i < _particleCount; i++) {
      _particles.add(
        _Particle(
          position: Offset(
            _random.nextDouble() * size.width,
            _random.nextDouble() * size.height,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 0.2, // Slower speed
            (_random.nextDouble() - 0.5) * 0.2,
          ),
          size: 2 + _random.nextDouble() * 4,
          color: AppColors.primary.withOpacity(
            0.1 + _random.nextDouble() * 0.2,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            _initParticles(Size(constraints.maxWidth, constraints.maxHeight));
            return CustomPaint(
              painter: _ParticlePainter(
                particles: _particles,
                mousePosition: context.watch<MouseProvider>().position,
              ),
              size: Size.infinite,
            );
          },
        );
      },
    );
  }
}

class _Particle {
  Offset position;
  Offset velocity;
  final double size;
  final Color color;

  _Particle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Offset mousePosition;

  _ParticlePainter({required this.particles, required this.mousePosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var particle in particles) {
      // Update position
      particle.position += particle.velocity;

      // Bounce off walls
      if (particle.position.dx < 0 || particle.position.dx > size.width) {
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      }
      if (particle.position.dy < 0 || particle.position.dy > size.height) {
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      }

      // Mouse interaction (repel)
      final distToMouse = (particle.position - mousePosition).distance;
      if (distToMouse < 150) {
        final repelDir = (particle.position - mousePosition) / distToMouse;
        particle.position += repelDir * (150 - distToMouse) * 0.05;
      }

      // Draw particle
      paint.color = particle.color;
      canvas.drawCircle(particle.position, particle.size, paint);

      // Draw connections
      for (var other in particles) {
        final dist = (particle.position - other.position).distance;
        if (dist < 100) {
          paint.color = AppColors.primary.withOpacity(
            (1 - dist / 100) * 0.05,
          ); // More subtle
          paint.strokeWidth = 1;
          canvas.drawLine(particle.position, other.position, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
