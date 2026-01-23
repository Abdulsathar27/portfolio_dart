import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:profitillo/providers/mouse_provider.dart';

class MagneticButton extends StatefulWidget {
  final Widget child;
  final double intensity;
  final VoidCallback? onTap;

  const MagneticButton({
    super.key,
    required this.child,
    this.intensity = 0.3,
    this.onTap,
  });

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _target = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(PointerEvent event) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final center = position + Offset(box.size.width / 2, box.size.height / 2);
    final delta = event.position - center;

    if (mounted) {
      setState(() {
        _target = delta * widget.intensity;
      });
    }

    // Animate to target
    _animation = Tween<Offset>(
      begin: _animation.value,
      end: _target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0);
  }

  void _handleExit(PointerEvent event) {
    if (mounted) {
      setState(() {
        _target = Offset.zero;
      });
    }
    _animation = Tween<Offset>(
      begin: _animation.value,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward(from: 0);

    context.read<MouseProvider>().setHoveringInteractive(false);
  }

  void _handleEnter(PointerEvent event) {
    context.read<MouseProvider>().setHoveringInteractive(true);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _handleEnter,
      onExit: _handleExit,
      onHover: _handleHover,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _animation.value,
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}
