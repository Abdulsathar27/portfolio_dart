import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/widgets/project_carousel.dart';
import 'package:profitillo/widgets/project_detail_dialog.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Featured Projects",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "A selection of my recent work",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 60),
          ProjectCarousel(
            projects: mockProjects,
            onProjectTap: (project) {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: "Project Details",
                barrierColor: Colors.black.withValues(alpha: 0.8),
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, _, __) =>
                    ProjectDetailDialog(project: project),
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutBack,
                          ),
                          child: child,
                        ),
                      );
                    },
              );
            },
          ),
        ],
      ),
    );
  }
}
