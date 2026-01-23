import 'package:flutter/material.dart';

class HoverTiltCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const HoverTiltCard({super.key, required this.child, this.onTap});

  @override
  State<HoverTiltCard> createState() => _HoverTiltCardState();
}

class _HoverTiltCardState extends State<HoverTiltCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _tiltAnimation;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _tiltAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -10),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) {
        _controller.reverse();
        if (mounted) setState(() => _mousePos = Offset.zero);
      },
      onHover: (details) {
        final size = context.size!;
        final center = Offset(size.width / 2, size.height / 2);
        if (mounted) {
          setState(() {
            _mousePos = (details.localPosition - center) / 20; // Sensitivity
          });
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..rotateX(-_mousePos.dy * 0.01 * _controller.value)
                ..rotateY(_mousePos.dx * 0.01 * _controller.value)
                ..translateByDouble(
                  _tiltAnimation.value.dx,
                  _tiltAnimation.value.dy,
                  0,
                  0,
                ),
              alignment: Alignment.center,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
