import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/widgets/interactive_social_icon.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).scaffoldBackgroundColor.withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(
                color: AppColors.primary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                    "Crafted with Flutter & passion.",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms, color: AppColors.primary)
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const InteractiveSocialIcon(
                    icon: FontAwesomeIcons.github,
                    url: "https://github.com/Abdulsathar27",
                  ),
                  const SizedBox(width: 24),
                  const InteractiveSocialIcon(
                    icon: FontAwesomeIcons.linkedin,
                    url: "https://www.linkedin.com/in/abdul-sathar-nechithodi/",
                  ),
                  const SizedBox(width: 24),
                  const InteractiveSocialIcon(
                    icon: FontAwesomeIcons.envelope,
                    url: "mailto:abdulsatharnecchithodi@gmail.com",
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms).scaleXY(begin: 0.5, end: 1.0),
              const SizedBox(height: 30),
              Text(
                "© ${DateTime.now().year} ${AppStrings.name}. All rights reserved.",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
