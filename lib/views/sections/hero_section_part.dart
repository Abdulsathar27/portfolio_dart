import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class _ScrollIndicator extends StatelessWidget {
  const _ScrollIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Scroll Down",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 30)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .moveY(
              begin: -5,
              end: 5,
              duration: 1000.ms,
              curve: Curves.easeInOut,
            ),
      ],
    );
  }
}
