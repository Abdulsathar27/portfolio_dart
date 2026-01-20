import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/providers/theme_provider.dart';

class ThemeAwareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ThemeAwareCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? AppColors.primary.withOpacity(0.3)
              : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppColors.primary.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
            blurRadius: isDark ? 20 : 30,
            spreadRadius: isDark ? 2 : 5,
            offset: isDark ? const Offset(0, 0) : const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
