import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/providers/mouse_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class InteractiveIllustration extends StatelessWidget {
  const InteractiveIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: Consumer<MouseProvider>(
        builder: (context, mouse, child) {
          final size = MediaQuery.of(context).size;
          final centerX = size.width / 2;
          final centerY = size.height / 2;

          // Calculate tilt angles based on mouse position relative to center
          // Max tilt is limited to avoid extreme angles
          final double tiltX = (mouse.position.dy - centerY) / centerY * -0.1;
          final double tiltY = (mouse.position.dx - centerX) / centerX * 0.1;

          return TweenAnimationBuilder<Offset>(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            tween: Tween<Offset>(begin: Offset.zero, end: Offset(tiltX, tiltY)),
            builder: (context, offset, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Perspective
                  ..rotateX(offset.dx)
                  ..rotateY(offset.dy),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Glow
                    Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: 0.2),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.7],
                            ),
                          ),
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.2, 1.2),
                          duration: 3000.ms,
                        ),

                    // Rotating Rings
                    _RotatingRing(
                      size: 280,
                      color: AppColors.primary.withValues(alpha: 0.1),
                      speed: 20000,
                    ),
                    _RotatingRing(
                      size: 220,
                      color: AppColors.primary.withValues(alpha: 0.2),
                      speed: -15000,
                    ),
                    _RotatingRing(
                      size: 160,
                      color: AppColors.primary.withValues(alpha: 0.3),
                      speed: 10000,
                    ),

                    // Core Element
                    Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.code,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1.1, 1.1),
                          duration: 1500.ms,
                        ),

                    // Floating Elements (3D Parallax)
                    _FloatingElement(
                      offset: const Offset(-100, -80),
                      depth: 20,
                      child: _TechIcon(Icons.flutter_dash, Colors.blue),
                    ),
                    _FloatingElement(
                      offset: const Offset(120, -40),
                      depth: 40,
                      child: _TechIcon(Icons.phone_android, Colors.green),
                    ),
                    _FloatingElement(
                      offset: const Offset(-60, 100),
                      depth: 30,
                      child: _TechIcon(Icons.web, Colors.orange),
                    ),
                    _FloatingElement(
                      offset: const Offset(80, 80),
                      depth: 50,
                      child: _TechIcon(Icons.cloud, Colors.purple),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _RotatingRing extends StatelessWidget {
  final double size;
  final Color color;
  final int speed;

  const _RotatingRing({
    required this.size,
    required this.color,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .rotate(duration: speed.abs().ms, begin: 0, end: speed > 0 ? 1 : -1);
  }
}

class _FloatingElement extends StatelessWidget {
  final Offset offset;
  final double depth;
  final Widget child;

  const _FloatingElement({
    required this.offset,
    required this.depth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
          offset: offset,
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, 0.0, depth),
            child: child,
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .moveY(
          begin: -10,
          end: 10,
          duration: (2000 + math.Random().nextInt(1000)).ms,
          curve: Curves.easeInOut,
        );
  }
}

class _TechIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _TechIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }
}
