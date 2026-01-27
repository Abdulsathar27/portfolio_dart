import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/models/skill.dart';
import 'package:profitillo/widgets/skill_tooltip.dart';

class InteractiveSkillCard extends StatefulWidget {
  final Skill skill;
  final bool isDimmed;
  final VoidCallback? onHover;

  const InteractiveSkillCard({
    super.key,
    required this.skill,
    this.isDimmed = false,
    this.onHover,
  });

  @override
  State<InteractiveSkillCard> createState() => _InteractiveSkillCardState();
}

class _InteractiveSkillCardState extends State<InteractiveSkillCard> {
  final ValueNotifier<bool> _isHovering = ValueNotifier(false);
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    _isHovering.dispose();
    _mousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _isHovering.value = true;
        widget.onHover?.call();
      },
      onExit: (_) {
        _isHovering.value = false;
        _mousePos.value = Offset.zero;
      },
      onHover: (event) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final center = box.size.center(Offset.zero);
        final localPos = box.globalToLocal(event.position);
        _mousePos.value = localPos - center;
      },
      child: RepaintBoundary(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _isHovering,
              builder: (context, isHovering, child) {
                return ValueListenableBuilder<Offset>(
                  valueListenable: _mousePos,
                  builder: (context, mousePos, _) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      transform: Matrix4.identity()
                        ..translate(
                          isHovering ? mousePos.dx * 0.1 : 0.0,
                          isHovering ? mousePos.dy * 0.1 : 0.0,
                        )
                        ..scale(
                          isHovering ? 1.05 : (widget.isDimmed ? 0.95 : 1.0),
                        ),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: widget.isDimmed && !isHovering ? 0.3 : 1.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isHovering
                                  ? AppColors.primary
                                  : AppColors.primary.withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                            color: isHovering
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            boxShadow: [
                              if (isHovering)
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.skill.iconUrl != null) ...[
                                    if (widget.skill.iconUrl!.startsWith(
                                      'http',
                                    ))
                                      Image.network(
                                        widget.skill.iconUrl!,
                                        width: 24,
                                        height: 24,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                      )
                                    else
                                      Image.asset(
                                        widget.skill.iconUrl!,
                                        width: 24,
                                        height: 24,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                      ),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(
                                    widget.skill.name,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isHovering
                                              ? AppColors.primary
                                              : Colors.white70,
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
                );
              },
            ),
            // Tooltip Overlay
            ValueListenableBuilder<bool>(
              valueListenable: _isHovering,
              builder: (context, isHovering, _) {
                if (!isHovering) return const SizedBox.shrink();
                return Positioned(
                  top: -80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      child: SkillTooltip(
                        description: widget.skill.description,
                        usageExample: widget.skill.usageExample,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
