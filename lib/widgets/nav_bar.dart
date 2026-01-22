import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/providers/theme_provider.dart';
import 'package:profitillo/providers/navigation_provider.dart';
import 'package:profitillo/widgets/responsive_wrapper.dart';
import 'package:profitillo/widgets/magnetic_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MagneticButton(
                child: Text(
                  AppStrings.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (ResponsiveWrapper.isDesktop(context))
                Row(
                  children: [
                    _NavButton(
                      title: AppStrings.aboutMe,
                      onTap: () => navProvider.scrollTo(navProvider.aboutMeKey),
                    ),
                    _NavButton(
                      title: AppStrings.projects,
                      onTap: () =>
                          navProvider.scrollTo(navProvider.projectsKey),
                    ),
                    _NavButton(
                      title: AppStrings.skills,
                      onTap: () => navProvider.scrollTo(navProvider.skillsKey),
                    ),
                    _NavButton(
                      title: AppStrings.contact,
                      onTap: () => navProvider.scrollTo(navProvider.contactKey),
                    ),
                    const SizedBox(width: 20),
                    const _ThemeToggle(),
                  ],
                )
              else
                Row(
                  children: [
                    const _ThemeToggle(),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MagneticButton(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: _isHovering ? AppColors.primary : null,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovering ? 20 : 0,
                color: AppColors.primary,
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
    return MagneticButton(
      onTap: themeProvider.toggleTheme,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          size: 20,
        ),
      ),
    );
  }
}
