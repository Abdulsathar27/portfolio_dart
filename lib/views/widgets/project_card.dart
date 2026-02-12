import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/providers/animation_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final int index;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardId = 'project_card_$index';

    return Selector<AnimationStateProvider, bool>(
      selector: (_, provider) => provider.isHovering(cardId),
      builder: (context, isHovering, _) {
        return MouseRegion(
          onEnter: (_) {
            context.read<AnimationStateProvider>().setHover(cardId, true);
          },
          onExit: (_) {
            context.read<AnimationStateProvider>().setHover(cardId, false);
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap:
                onTap ??
                () async {
                  if (project.codeUrl != null) {
                    final uri = Uri.parse(project.codeUrl!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  }
                },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translate(0.0, isHovering ? -8.0 : 0.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isHovering
                      ? Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.1),
                  width: isHovering ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withValues(
                      alpha: isHovering ? 0.15 : 0.0,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // Allow column to shrink wrap content
                  children: [
                    // Title
                    Text(
                          project.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                        )
                        .animate(target: isHovering ? 1 : 0)
                        .scaleXY(
                          end: 1.02,
                          duration: 200.ms,
                          curve: Curves.easeOut,
                        ),

                    const SizedBox(height: 8),

                    // Purpose
                    Text(
                      project.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      maxLines: 3, // Allow 1 more line if needed, or keep 2
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 24),

                    // Highlights
                    ...project.highlights
                        .take(3)
                        .map(
                          (highlight) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    highlight,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant
                                          .withValues(alpha: 0.9),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                    const SizedBox(
                      height: 24,
                    ), // Replaced Spacer with fixed space
                    // Tags
                    Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: project.tags.take(4).map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            );
                          }).toList(),
                        )
                        .animate()
                        .fadeIn(delay: (100 * index).ms + 200.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 24),

                    // CTA
                    Row(
                      children: [
                        Text(
                          "View Code",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            )
                            .animate(target: isHovering ? 1 : 0)
                            .moveX(
                              end: 4,
                              duration: 200.ms,
                              curve: Curves.easeOut,
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
