import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/models/timeline_item.dart';

class AnimatedTimeline extends StatefulWidget {
  final List<TimelineItem> items;

  const AnimatedTimeline({super.key, required this.items});

  @override
  State<AnimatedTimeline> createState() => _AnimatedTimelineState();
}

class _AnimatedTimelineState extends State<AnimatedTimeline>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final itemProgress = (index + 1) / widget.items.length;
            final isVisible =
                _animation.value >= itemProgress - (1.0 / widget.items.length);

            return Opacity(
              opacity: isVisible ? 1.0 : 0.0,
              child: Transform.translate(
                offset: Offset(0, isVisible ? 0 : 20),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left Side: Date/Period
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, right: 20),
                          child: Text(
                            item.period,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      // Center: Timeline Line and Dot
                      SizedBox(
                        width: 20,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            // Vertical Line
                            if (index != widget.items.length - 1)
                              Positioned(
                                top: 12,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width: 2,
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            // Dot
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Right Side: Content
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Role Title
                              Text(
                                item.title,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Company Name
                              Text(
                                item.company,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Description
                              Text(
                                item.description,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Responsibilities
                              ...item.responsibilities.map(
                                (resp) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.6,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          resp,
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            height: 1.5,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Skills
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: item.skills.map((skill) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.05,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      skill,
                                      style: GoogleFonts.spaceMono(
                                        fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
