import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/views/widgets/project_card.dart';
import '../../core/utils/responsive_utils.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 20 : 40,
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
                  // Apply Option A: SliverGridDelegateWithMaxCrossAxisExtent
                  // content width checks to determine optimal maxExtent and aspect ratio
                  // If desktop (width >= tabletBreakpoint), we might want 3 columns max.
                  // 1200 / 3 = 400. So maxCrossAxisExtent = 400.
                  // If tablet, still good.

                  double childAspectRatio =
                      0.75; // Default safe vertical aspect ratio (height > width)
                  // On very wide screens, 0.75 might be TOO tall if the card is wide.
                  // If screen is narrow, 0.75 is good.

                  if (ResponsiveUtils.isDesktop(context)) {
                    childAspectRatio = 0.8;
                  } else if (ResponsiveUtils.isTablet(context)) {
                    childAspectRatio = 0.8;
                  } else {
                    childAspectRatio = 0.75;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: mockProjects.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(
                            project: mockProjects[index],
                            index: index,
                          )
                          .animate()
                          .fadeIn(delay: (100 * index).ms, duration: 600.ms)
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            curve: Curves.easeOutQuad,
                          );
                    },
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
