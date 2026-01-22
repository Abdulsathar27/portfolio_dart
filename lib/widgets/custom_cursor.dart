import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/mouse_provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class CustomCursor extends StatelessWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MouseProvider>(
      builder: (context, provider, child) {
        return IgnorePointer(
          child: Stack(
            children: [
              // Main dot
              AnimatedPositioned(
                duration: const Duration(milliseconds: 50), // Snappier
                curve: Curves.easeOut,
                left:
                    provider.position.dx -
                    (provider.isHoveringInteractive ? 20 : 10),
                top:
                    provider.position.dy -
                    (provider.isHoveringInteractive ? 20 : 10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: provider.isHoveringInteractive ? 40 : 20,
                  height: provider.isHoveringInteractive ? 40 : 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: provider.isHoveringInteractive
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primary,
                    border: provider.isHoveringInteractive
                        ? Border.all(color: AppColors.primary, width: 2)
                        : null,
                  ),
                ),
              ),
              // Trailing dot
              AnimatedPositioned(
                duration: const Duration(milliseconds: 20), // Very snappy
                curve: Curves.easeOut,
                left: provider.position.dx - 4,
                top: provider.position.dy - 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
