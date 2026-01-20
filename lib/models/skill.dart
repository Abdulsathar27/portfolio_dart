class Skill {
  final String name;
  final String? iconUrl; // Or use IconData if preferred
  final double proficiency; // 0.0 to 1.0

  final String description;
  final String usageExample;

  const Skill({
    required this.name,
    this.iconUrl,
    this.proficiency = 0.0,
    required this.description,
    required this.usageExample,
  });
}
