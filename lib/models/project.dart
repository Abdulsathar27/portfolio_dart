class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String? codeUrl;
  final String? demoUrl;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    this.codeUrl,
    this.demoUrl,
  });
}

final List<Project> mockProjects = [
  const Project(
    title: "AutoCare App",
    description:
        "A service booking application built using Flutter and Firebase. Includes user authentication, service booking flow, booking status tracking, and provider-side dashboards with Firestore integration.",
    tags: ["Flutter", "Firebase Auth", "Firestore", "Provider"],
    codeUrl: "https://github.com",
  ),

  const Project(
    title: "Shopping Hub (E-Commerce)",
    description:
        "A modern e-commerce application developed using Flutter. Implemented REST API integration with Dio, Provider state management, MVC architecture, and search functionality with a clean UI.",
    tags: ["Flutter", "REST API", "Dio", "Provider", "MVC"],
    codeUrl: "https://github.com",
  ),

  const Project(
    title: "Student Record App",
    description:
        "A student management application using Flutter and Hive local database. Supports adding, editing, searching student records with image picker integration and reusable form components.",
    tags: ["Flutter", "Hive", "Local Storage", "Image Picker"],
    codeUrl: "https://github.com",
  ),

  const Project(
    title: "Cafe Today App",
    description:
        "A smart cafe ordering application built with Flutter and Hive. Focused on local data storage, clean UI design, and smooth user experience for managing cafe orders.",
    tags: ["Flutter", "Hive", "Local Database", "UI Design"],
    codeUrl: "https://github.com",
  ),
];

