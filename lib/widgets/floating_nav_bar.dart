import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/providers/navigation_provider.dart';
import 'package:profitillo/providers/theme_provider.dart';

class FloatingNavBar extends StatefulWidget {
  final ScrollController scrollController;

  const FloatingNavBar({super.key, required this.scrollController});

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  bool _isVisible = true;
  double _lastScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final currentOffset = widget.scrollController.offset;
    if (currentOffset > _lastScrollOffset && currentOffset > 50) {
      if (_isVisible) setState(() => _isVisible = false);
    } else {
      if (!_isVisible) setState(() => _isVisible = true);
    }
    _lastScrollOffset = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: _isVisible ? Offset.zero : const Offset(0, -1.5),
      child: Center(
        heightFactor: 1,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavIcon(
                      icon: Icons.person_outline,
                      label: AppStrings.aboutMe,
                      onTap: () =>
                          Provider.of<NavigationProvider>(
                            context,
                            listen: false,
                          ).scrollTo(
                            Provider.of<NavigationProvider>(
                              context,
                              listen: false,
                            ).aboutMeKey,
                          ),
                    ),
                    _NavIcon(
                      icon: Icons.work_outline,
                      label: AppStrings.experience,
                      onTap: () =>
                          Provider.of<NavigationProvider>(
                            context,
                            listen: false,
                          ).scrollTo(
                            Provider.of<NavigationProvider>(
                              context,
                              listen: false,
                            ).experienceKey,
                          ),
                    ),
                    _NavIcon(
                      icon: Icons.code,
                      label: AppStrings.projects,
                      onTap: () =>
                          Provider.of<NavigationProvider>(
                            context,
                            listen: false,
                          ).scrollTo(
                            Provider.of<NavigationProvider>(
                              context,
                              listen: false,
                            ).projectsKey,
                          ),
                    ),
                    _NavIcon(
                      icon: Icons.bolt,
                      label: AppStrings.skills,
                      onTap: () =>
                          Provider.of<NavigationProvider>(
                            context,
                            listen: false,
                          ).scrollTo(
                            Provider.of<NavigationProvider>(
                              context,
                              listen: false,
                            ).skillsKey,
                          ),
                    ),
                    _NavIcon(
                      icon: Icons.mail_outline,
                      label: AppStrings.contact,
                      onTap: () =>
                          Provider.of<NavigationProvider>(
                            context,
                            listen: false,
                          ).scrollTo(
                            Provider.of<NavigationProvider>(
                              context,
                              listen: false,
                            ).contactKey,
                          ),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                    const _ThemeToggle(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<_NavIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: _isHovering ? 16 : 12,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _isHovering
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: _isHovering
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  width: _isHovering ? null : 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      onPressed: themeProvider.toggleTheme,
      icon: Icon(
        themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        size: 20,
        color: AppColors.textSecondary,
      ),
    );
  }
}
