import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/views/widgets/project_card.dart';
import '../../core/utils/responsive_utils.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // We can rely on LayoutBuilder for maxWidth constraints,
    // but we can also use ResponsiveUtils for general breakpoints if we want to be consistent with other sections.

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: ResponsiveUtils.isMobile(context) ? 20 : 40,
      ),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
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
                  // Determine columns based on available width
                  int columns = 1;
                  if (constraints.maxWidth >= 1024) {
                    columns = 3;
                  } else if (constraints.maxWidth >= 600) {
                    columns = 2;
                  }

                  // Calculate card width
                  // Total width = (cardWidth * columns) + (spacing * (columns - 1))
                  // cardWidth = (Total width - (spacing * (columns - 1))) / columns
                  const double spacing = 24.0;
                  final double totalSpacing = spacing * (columns - 1);
                  final double cardWidth =
                      (constraints.maxWidth - totalSpacing) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: List.generate(mockProjects.length, (index) {
                      return SizedBox(
                            width: cardWidth,
                            // No height constraint here, let it grow!
                            child: ProjectCard(
                              project: mockProjects[index],
                              index: index,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: (100 * index).ms, duration: 600.ms)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            curve: Curves.easeOutQuad,
                          );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
