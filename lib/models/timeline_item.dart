class TimelineItem {
  final String year;
  final String title;
  final String description;

  final String company;
  final String period;
  final List<String> responsibilities;
  final List<String> skills;

  const TimelineItem({
    required this.year,
    required this.title,
    required this.description,
    required this.company,
    required this.period,
    required this.responsibilities,
    required this.skills,
  });
}
