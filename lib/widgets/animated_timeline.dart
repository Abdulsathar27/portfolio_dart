import 'package:flutter/material.dart';
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
    // Start animation when widget builds (could be triggered by visibility detector)
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
        return CustomPaint(
          painter: _TimelinePainter(
            itemCount: widget.items.length,
            progress: _animation.value,
            color: AppColors.primary,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              // Calculate if this item should be visible based on progress
              final itemProgress = (index + 1) / widget.items.length;
              final isVisible =
                  _animation.value >=
                  itemProgress - (1.0 / widget.items.length);

              return Opacity(
                opacity: isVisible ? 1.0 : 0.0,
                child: Transform.translate(
                  offset: Offset(0, isVisible ? 0 : 20),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.year,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  final int itemCount;
  final double progress;
  final Color color;

  _TimelinePainter({
    required this.itemCount,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw vertical line
    final totalHeight = size.height;
    final lineHeight = totalHeight * progress;

    // Line is positioned at left: 20 (center of 40px padding area roughly)
    // Actually, let's align it with the dots.
    // Dots are usually at the start of the item.

    // We need to know the positions of items, but ListView lays them out.
    // For a simple effect, we can just draw a line down the left side.

    canvas.drawLine(const Offset(15, 0), Offset(15, lineHeight), paint);

    // Draw dots based on progress
    // This is tricky without exact item positions.
    // A better approach for exact alignment is to have the items themselves draw the dots/line segments.
    // But for this "drawing" animation, a continuous line is nice.
    // Let's stick to the line for now and maybe add dots in the widget tree if needed,
    // or assume uniform height (which is risky).

    // Alternative: The widget tree above has padding-left: 40.
    // So the line should be around x=15-20.
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
