import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/data/mock_data.dart';
import 'package:profitillo/widgets/animated_timeline.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Learning Journey",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 40),
          AnimatedTimeline(items: MockData.experience),
        ],
      ),
    );
  }
}
