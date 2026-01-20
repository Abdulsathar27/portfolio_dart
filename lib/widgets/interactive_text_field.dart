import 'package:flutter/material.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class InteractiveTextField extends StatefulWidget {
  final String label;
  final int maxLines;
  final TextEditingController? controller;

  const InteractiveTextField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.controller,
  });

  @override
  State<InteractiveTextField> createState() => _InteractiveTextFieldState();
}

class _InteractiveTextFieldState extends State<InteractiveTextField> {
  bool _isFocused = false;
  bool _isHovering = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isFocused || _isHovering
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.2),
            width: _isFocused ? 1.5 : 1.0,
          ),
          boxShadow: [
            if (_isFocused)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 12,
                spreadRadius: 2,
              ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: _isFocused
                  ? AppColors.primary
                  : AppColors.textSecondary.withValues(alpha: 0.7),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
