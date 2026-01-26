import 'package:profitillo/models/skill.dart';
import 'package:profitillo/models/skill_category.dart';
import 'package:profitillo/models/timeline_item.dart';

class MockData {
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Flutter & Dart',
      skills: [
        Skill(
          name: 'Flutter',
          proficiency: 0.95,
          description: 'Cross-platform UI toolkit',
          usageExample: 'Built responsive mobile & web applications',
          iconUrl:
              'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        ),
        Skill(
          name: 'Dart',
          proficiency: 0.95,
          description: 'Optimized language for UI',
          usageExample: 'Developed core logic and data models',
          iconUrl:
              'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png',
        ),
        Skill(
          name: 'Widget Testing',
          proficiency: 0.85,
          description: 'UI Component Testing',
          usageExample: 'Ensured widget reliability and regression testing',
        ),
      ],
    ),
    SkillCategory(
      title: 'State Management',
      skills: [
        Skill(
          name: 'Riverpod',
          proficiency: 0.90,
          description: 'Compile-safe State Management',
          usageExample: 'Managed complex app state with dependency injection',
        ),
        Skill(
          name: 'Provider',
          proficiency: 0.90,
          description: 'InheritedWidget Wrapper',
          usageExample: 'Simple state sharing across widget tree',
        ),
        Skill(
          name: 'Bloc',
          proficiency: 0.80,
          description: 'Business Logic Component',
          usageExample: 'Separated business logic from UI events',
        ),
      ],
    ),
    SkillCategory(
      title: 'Architecture',
      skills: [
        Skill(
          name: 'Clean Architecture',
          proficiency: 0.85,
          description: 'Separation of Concerns',
          usageExample: 'Implemented Domain, Data, and Presentation layers',
        ),
        Skill(
          name: 'MVVM',
          proficiency: 0.90,
          description: 'Model-View-ViewModel',
          usageExample: 'Decoupled UI from business logic',
        ),
      ],
    ),
    SkillCategory(
      title: 'Backend & Tools',
      skills: [
        Skill(
          name: 'Firebase',
          proficiency: 0.85,
          description: 'Backend-as-a-Service',
          usageExample: 'Auth, Firestore, Cloud Functions',
          iconUrl:
              'https://firebase.google.com/static/images/brand-guidelines/logo-logomark.png',
        ),
        Skill(
          name: 'REST API',
          proficiency: 0.80,
          description: 'Network Communication',
          usageExample: 'Integrated 3rd party services via HTTP',
        ),
        Skill(
          name: 'Git',
          proficiency: 0.90,
          description: 'Version Control',
          usageExample: 'Managed code history and collaboration',
          iconUrl:
              'https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png',
        ),
      ],
    ),
    SkillCategory(
      title: 'UI/UX',
      skills: [
        Skill(
          name: 'Figma',
          proficiency: 0.75,
          description: 'Interface Design',
          usageExample: 'Translated designs to pixel-perfect code',
        ),
        Skill(
          name: 'Animations',
          proficiency: 0.85,
          description: 'Interactive Motion',
          usageExample: 'Created custom implicit and explicit animations',
        ),
      ],
    ),
  ];

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
      period: 'May 2025 - Present',
      title: 'Flutter Developer',
      company: 'Bridgeon Solutions LLP',
      description:
          'Working as a Flutter developer, building responsive and interactive cross-platform applications. Focused on clean UI design, state management, and integrating real-world features while following best development practices.',
      responsibilities: [
        'Developed responsive UI screens using Flutter widgets for mobile and web platforms',
        'Implemented state management using Provider, GetX, and Riverpod based on project needs',
        'Integrated REST APIs and handled asynchronous data flow efficiently',
        'Worked with local storage solutions like Hive and Shared Preferences',
        'Collaborated with mentors and team members in an Agile development environment',
      ],
      skills: [
        'Flutter',
        'Dart',
        'State Management',
        'REST API Integration',
        'Hive',
        'Shared Preferences',
        'UI/UX',
        'Agile',
      ],
    ),

    // TimelineItem(
    //   year: '2025',
    //   period: 'Jan 2025 - Present',
    //   title: 'Senior Flutter Developer',
    //   company: 'TechInnovate Solutions',
    //   description:
    //       'Leading the mobile development team in building next-generation cross-platform applications. Architecting scalable solutions and mentoring junior developers.',
    //   responsibilities: [
    //     'Architected and implemented a modular state management system using Riverpod 2.0',
    //     'Reduced app startup time by 40% through optimized asset loading and lazy initialization',
    //     'Led a team of 4 developers, conducting code reviews and establishing best practices',
    //     'Integrated complex CI/CD pipelines using GitHub Actions for automated testing and deployment',
    //   ],
    //   skills: ['Flutter', 'Dart', 'Riverpod', 'CI/CD', 'System Design'],
    // ),
    // TimelineItem(
    //   year: '2023',
    //   period: 'Mar 2023 - Dec 2024',
    //   title: 'Mobile App Developer',
    //   company: 'Creative Digital Agency',
    //   description:
    //       'Developed and maintained multiple client applications across various industries including fintech, e-commerce, and healthcare.',
    //   responsibilities: [
    //     'Built pixel-perfect UIs from Figma designs with 100% fidelity',
    //     'Implemented secure payment gateway integrations (Stripe, PayPal)',
    //     'Optimized local data storage using Hive and SQLite for offline-first functionality',
    //     'Collaborated with backend teams to design RESTful APIs for mobile consumption',
    //   ],
    //   skills: ['Flutter', 'Firebase', 'REST APIs', 'Figma', 'Agile'],
    // ),
    // TimelineItem(
    //   year: '2022',
    //   period: 'Jun 2022 - Feb 2023',
    //   title: 'Junior Software Engineer',
    //   company: 'StartUp Inc.',
    //   description:
    //       'Started professional journey contributing to the core product development and bug fixing.',
    //   responsibilities: [
    //     'Assisted in migrating legacy Android code to Flutter',
    //     'Wrote comprehensive unit and widget tests achieving 80% code coverage',
    //     'Participated in daily stand-ups and sprint planning meetings',
    //     'Fixed critical production bugs and improved app stability',
    //   ],
    //   skills: ['Dart', 'Android', 'Git', 'Unit Testing'],
    // ),
  ];
}
