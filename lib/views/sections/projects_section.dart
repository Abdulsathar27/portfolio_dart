import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/views/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Featured Projects",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          Text(
            "A selection of my recent work",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w300,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: 80),

          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive layout logic
              int crossAxisCount = 1;
              if (constraints.maxWidth > 1100) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth > 700) {
                crossAxisCount = 2;
              }

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: List.generate(mockProjects.length, (index) {
                  final double itemWidth = crossAxisCount == 1
                      ? constraints.maxWidth
                      : (constraints.maxWidth - (24 * (crossAxisCount - 1))) /
                            crossAxisCount;

                  return SizedBox(
                        width: itemWidth,
                        height: 420, // Fixed height for consistency
                        child: ProjectCard(
                          project: mockProjects[index],
                          index: index,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms, duration: 600.ms)
                      .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
