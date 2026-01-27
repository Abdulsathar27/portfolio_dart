import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class AnimatedRoleTag extends StatelessWidget {
  const AnimatedRoleTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flutter_dash, color: AppColors.primary, size: 20)
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 2000.ms,
                    color: Colors.white.withValues(alpha: 0.5),
                  )
                  .shake(
                    hz: 4,
                    curve: Curves.easeInOutCubic,
                    duration: 1000.ms,
                    delay: 2000.ms,
                  ),

              const SizedBox(width: 10),

              Text(
                "Flutter Developer",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideX(begin: -0.2, end: 0, curve: Curves.easeOutBack)
        .shimmer(
          duration: 3000.ms,
          color: Colors.white.withValues(alpha: 0.2),
          delay: 1000.ms,
        );
  }
}
