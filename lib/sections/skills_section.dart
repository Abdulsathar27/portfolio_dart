import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/data/mock_data.dart';
import 'package:profitillo/widgets/interactive_skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      // Add subtle background noise or texture here if desired
      width: double.infinity,
      child: Column(
        children: [
          Text(
            AppStrings.skills,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
          const SizedBox(height: 60),
          Center(
            child: Wrap(
              spacing: 24,
              runSpacing: 40, // Increased for tooltip space
              alignment: WrapAlignment.center,
              children: MockData.skills
                  .asMap()
                  .entries
                  .map(
                    (entry) => InteractiveSkillCard(skill: entry.value)
                        .animate()
                        .fadeIn(delay: (100 * entry.key).ms, duration: 400.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          curve: Curves.easeOutBack,
                        ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
