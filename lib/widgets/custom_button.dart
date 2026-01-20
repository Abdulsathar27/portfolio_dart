import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/widgets/magnetic_button.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
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

    return MagneticButton(child: buttonContent);
  }
}
