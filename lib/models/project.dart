class Project {
  final String title;
  final String description;
  final List<String> tags;
  final List<String> highlights;
  final String? codeUrl;
  final String? demoUrl;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.highlights,
    this.codeUrl,
    this.demoUrl,
  });
}

final List<Project> mockProjects = [
  const Project(
    title: "AutoCare App",
    description:
        "A comprehensive service booking platform connecting vehicle owners with trusted mechanics.",
    highlights: [
      "Real-time booking status tracking with Firebase streams",
      "Provider dashboard for managing service requests",
      "Secure authentication & role-based access control",
    ],
    tags: ["Flutter", "Firebase", "Firestore", "Provider"],
    codeUrl: "https://github.com/Abdulsathar27/autocareapp",
    demoUrl: "https://github.com/Abdulsathar27/autocareapp",
  ),

  const Project(
    title: "Shopping Hub",
    description:
        "A modern, feature-rich e-commerce application with a clean MVC architecture.",
    highlights: [
      "Custom REST API integration using Dio",
      "Advanced product search & filtering logic",
      "Smooth cart & checkout state management",
    ],
    tags: ["Flutter", "REST API", "Dio", "MVC"],
    codeUrl: "https://github.com/Abdulsathar27/shopping_hub_flutterApi",
    demoUrl: "https://github.com/Abdulsathar27/shopping_hub_flutterApi",
  ),

  const Project(
    title: "Student Record",
    description:
        "Efficient student management system focused on data persistence and usability.",
    highlights: [
      "Offline-first architecture using Hive database",
      "Optimized image handling & caching",
      "Reusable form components with validation",
    ],
    tags: ["Flutter", "Hive", "Local Storage", "UI/UX"],
    codeUrl: "https://github.com/Abdulsathar27/crud_hive",
    demoUrl: "https://github.com/Abdulsathar27/crud_hive",
  ),

  const Project(
    title: "Cafe Today",
    description:
        "Smart ordering solution streamlining cafe operations and customer experience.",
    highlights: [
      "Instant local order processing with Hive",
      "Intuitive UI for rapid menu navigation",
      "Dark mode support & custom theming",
    ],
    tags: ["Flutter", "Hive", "Design System", "Motion"],
    codeUrl: "https://github.com/Abdulsathar27/cafe-today-",
    demoUrl: "https://github.com/Abdulsathar27/cafe-today-",
  ),
];
