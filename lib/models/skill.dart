import 'package:flutter/widgets.dart';

class Skill {
  final String name;
  final IconData? icon;
  final double proficiency; // 0.0 to 1.0

  final String description;
  final String usageExample;

  const Skill({
    required this.name,
    this.icon,
    this.proficiency = 0.0,
    required this.description,
    required this.usageExample,
  });
}
