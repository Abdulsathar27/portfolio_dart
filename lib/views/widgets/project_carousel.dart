import 'package:flutter/material.dart';
import 'package:profitillo/models/project.dart';
import 'package:profitillo/providers/animation_state_provider.dart';
import 'package:profitillo/views/widgets/project_card.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ProjectCarousel extends StatefulWidget {
  final List<Project> projects;
  final Function(Project) onProjectTap;

  const ProjectCarousel({
    super.key,
    required this.projects,
    required this.onProjectTap,
  });

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  late PageController _pageController;
  final double _viewportFraction = 0.5;
  final String _carouselId = 'project_carousel';

  @override
  void initState() {
    super.initState();
    final initialPage = context
        .read<AnimationStateProvider>()
        .getNumeric(_carouselId)
        .toInt();
    _pageController = PageController(
      initialPage: initialPage,
      viewportFraction: _viewportFraction,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.projects.length,
        onPageChanged: (index) {
          context.read<AnimationStateProvider>().setNumeric(
            _carouselId,
            index.toDouble(),
          );
        },
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              final currentPage = context
                  .watch<AnimationStateProvider>()
                  .getNumeric(_carouselId);

              double value = 0.0;
              if (_pageController.position.haveDimensions) {
                value = index - _pageController.page!;
                value = (value * 0.038).clamp(-1, 1);
              } else {
                // Initial state
                value = index == currentPage
                    ? 0.0
                    : (index > currentPage ? 1.0 : -1.0);
              }

              final double scale = max(0.8, 1.0 - value.abs());
              final double opacity = max(0.5, 1.0 - value.abs());
              final double rotateY = value * pi / 4; // Cover flow rotation

              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotateY),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(scale: scale, child: child),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ProjectCard(
                project: widget.projects[index],
                index: index,
                onTap: () => widget.onProjectTap(widget.projects[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
