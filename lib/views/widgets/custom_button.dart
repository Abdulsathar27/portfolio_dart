import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/views/widgets/magnetic_button.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // If width is provided, we can wrap in SizedBox.
    // However, magnetic effect might need to know about size.
    // MagneticButton wraps the child. If child is finite, magnetic works well.
    // If child is infinite width, magnetic might behave differently.

    final theme = Theme.of(context);
    final style = ElevatedButton.styleFrom(
      backgroundColor: isOutlined ? Colors.transparent : AppColors.primary,
      foregroundColor: isOutlined ? AppColors.primary : Colors.white,
      side: isOutlined ? const BorderSide(color: AppColors.primary) : null,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: width != null ? Size(width!, 50) : null,
    );

    Widget buttonContent;
    if (icon != null) {
      buttonContent = ElevatedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: Icon(icon, size: 18),
        label: Text(text),
      );
    } else {
      buttonContent = ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(text),
      );
    }

    // If wrapping in MagneticButton, ensure the button itself respects width.
    return SizedBox(
      width: width,
      child: MagneticButton(child: buttonContent),
    );
  }
}
