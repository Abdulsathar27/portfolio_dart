import 'package:flutter/material.dart';
import 'package:profitillo/providers/animation_state_provider.dart';
import 'package:provider/provider.dart';

class InteractiveTextField extends StatefulWidget {
  final String label;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const InteractiveTextField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.controller,
    this.validator,
  });

  @override
  State<InteractiveTextField> createState() => _InteractiveTextFieldState();
}

class _InteractiveTextFieldState extends State<InteractiveTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fieldId = 'text_field_${widget.label}';

    return Selector<AnimationStateProvider, bool>(
      selector: (_, provider) => provider.isHovering(fieldId),
      builder: (context, isHovering, _) {
        return MouseRegion(
          onEnter: (_) {
            context.read<AnimationStateProvider>().setHover(fieldId, true);
          },
          onExit: (_) {
            context.read<AnimationStateProvider>().setHover(fieldId, false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isFocused || isHovering
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                width: _isFocused ? 1.5 : 1.0,
              ),
              boxShadow: [
                if (_isFocused)
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              maxLines: widget.maxLines,
              validator: widget.validator,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: TextStyle(
                  color: _isFocused
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        );
      },
    );
  }
}
