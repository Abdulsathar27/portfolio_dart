import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? highlightColor;

  const HighlightText({
    super.key,
    required this.text,
    this.style,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The highlight underline
        Positioned(
          bottom: 2,
          left: 0,
          right: 0,
          height: 8,
          child:
              Container(
                color: (highlightColor ?? AppColors.primary).withOpacity(0.3),
              ).animate().scaleX(
                alignment: Alignment.centerLeft,
                duration: 600.ms,
                curve: Curves.easeOut,
                delay: 400.ms,
              ),
        ),
        // The text
        Text(text, style: style),
      ],
    );
  }
}
