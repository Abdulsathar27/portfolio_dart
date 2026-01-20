import 'dart:math';
import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class AnimatedSkillChart extends StatefulWidget {
  final String label;
  final double proficiency; // 0.0 to 1.0

  const AnimatedSkillChart({
    super.key,
    required this.label,
    required this.proficiency,
  });

  @override
  State<AnimatedSkillChart> createState() => _AnimatedSkillChartState();
}

class _AnimatedSkillChartState extends State<AnimatedSkillChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.proficiency,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    // Start animation on build
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _SkillPainter(
                  progress: _animation.value,
                  color: AppColors.primary,
                  backgroundColor: AppColors.primary.withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    "${(_animation.value * 100).toInt()}%",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _SkillPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _SkillPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 8.0;

    // Draw background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2, // Start from top
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SkillPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
