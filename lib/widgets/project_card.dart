import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/providers/mouse_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class ProjectCard extends StatefulWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Consumer<MouseProvider>(
          builder: (context, mouse, child) {
            // 3D Tilt Effect
            final isHovering = _isHovering;
            final center = MediaQuery.of(context).size.center(Offset.zero);
            // Simple tilt based on mouse position relative to screen center for now
            // For more local tilt, we'd need the render box of the card
            final tiltX = isHovering
                ? (mouse.position.dy - center.dy) * 0.001
                : 0.0;
            final tiltY = isHovering
                ? (center.dx - mouse.position.dx) * 0.001
                : 0.0;

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..rotateX(tiltX)
                ..rotateY(tiltY),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(
                      alpha: isHovering ? 0.5 : 0.1,
                    ),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: isHovering ? 0.2 : 0.05,
                      ),
                      blurRadius: isHovering ? 30 : 10,
                      spreadRadius: isHovering ? 5 : 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Theme.of(context).cardColor.withValues(alpha: 0.6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.project.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: widget.project.tags.take(3).map((
                                      tag,
                                    ) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.2,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          tag,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        "Learn More",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                        color: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
