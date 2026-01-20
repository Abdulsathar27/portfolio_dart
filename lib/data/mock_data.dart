import 'package:profitillo/models/skill.dart';
import 'package:profitillo/models/timeline_item.dart';

class MockData {
  static const List<Skill> skills = [
    Skill(
      name: 'Flutter',
      proficiency: 0.95,
      description: 'Cross-platform UI toolkit',
      usageExample: 'Built responsive mobile & web applications',
    ),
    Skill(
      name: 'Dart',
      proficiency: 0.95,
      description: 'Optimized language for UI',
      usageExample: 'Developed core logic and data models',
    ),
    Skill(
      name: 'Firebase',
      proficiency: 0.85,
      description: 'Backend-as-a-Service',
      usageExample: 'Handled authentication and real-time data',
    ),
    Skill(
      name: 'Rest API',
      proficiency: 0.80,
      description: 'Network communication',
      usageExample: 'Integrated 3rd party services and data fetching',
    ),
    Skill(
      name: 'Git',
      proficiency: 0.90,
      description: 'Version Control',
      usageExample: 'Managed code collaboration and versioning',
    ),
    Skill(
      name: 'UI/UX Design',
      proficiency: 0.75,
      description: 'User Interface Design',
      usageExample: 'Created intuitive and accessible user experiences',
    ),
    Skill(
      name: 'Clean Architecture',
      proficiency: 0.85,
      description: 'Software Design Pattern',
      usageExample: 'Structured app for scalability and testability',
    ),
    Skill(
      name: 'Provider/Riverpod',
      proficiency: 0.90,
      description: 'State Management',
      usageExample: 'Managed app state across multiple screens',
    ),
  ];

  static const List<TimelineItem> experience = [
    TimelineItem(
      year: '2025',
      title: 'Flutter Developer',
      description:
          'Dived deep into Flutter development, learning how to build scalable UI, manage app state, integrate APIs, and create smooth user experiences through hands-on projects.',
    ),
  ];
}
