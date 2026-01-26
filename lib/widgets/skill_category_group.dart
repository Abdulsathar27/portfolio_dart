import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/models/skill_category.dart';
import 'package:profitillo/widgets/interactive_skill_card.dart';

class SkillCategoryGroup extends StatelessWidget {
  final SkillCategory category;
  final String? hoveredSkillName;
  final ValueChanged<String?> onHoverSkill;
  final int index;

  const SkillCategoryGroup({
    super.key,
    required this.category,
    required this.hoveredSkillName,
    required this.onHoverSkill,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: (100 * index).ms)
            .slideX(begin: -0.1, curve: Curves.easeOut),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: category.skills.map((skill) {
            final isDimmed =
                hoveredSkillName != null && hoveredSkillName != skill.name;
            return InteractiveSkillCard(
                  skill: skill,
                  isDimmed: isDimmed,
                  onHover: () => onHoverSkill(skill.name),
                )
                .animate()
                .fadeIn(
                  duration: 500.ms,
                  delay:
                      (100 * index + 100 * category.skills.indexOf(skill)).ms,
                )
                .scale(
                  begin: const Offset(0.9, 0.9),
                  curve: Curves.easeOutBack,
                );
          }).toList(),
        ),
      ],
    );
  }
}
