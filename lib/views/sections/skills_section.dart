import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/data/mock_data.dart';
import 'package:profitillo/views/widgets/skill_category_group.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  String? _hoveredSkillName;

  void _onHoverSkill(String? skillName) {
    if (!mounted) return;
    if (_hoveredSkillName != skillName) {
      setState(() {
        _hoveredSkillName = skillName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.skills,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
          const SizedBox(height: 60),
          MouseRegion(
            onExit: (_) => _onHoverSkill(null),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MockData.skillCategories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 48),
              itemBuilder: (context, index) {
                final category = MockData.skillCategories[index];
                return SkillCategoryGroup(
                  category: category,
                  hoveredSkillName: _hoveredSkillName,
                  onHoverSkill: _onHoverSkill,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
