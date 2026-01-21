import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/mouse_provider.dart';

class MagneticText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double strength;

  const MagneticText({
    super.key,
    required this.text,
    required this.style,
    this.strength = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: text.split('').map((char) {
        return _MagneticLetter(
          character: char,
          style: style,
          strength: strength,
        );
      }).toList(),
    );
  }
}

class _MagneticLetter extends StatefulWidget {
  final String character;
  final TextStyle style;
  final double strength;

  const _MagneticLetter({
    required this.character,
    required this.style,
    required this.strength,
  });

  @override
  State<_MagneticLetter> createState() => _MagneticLetterState();
}

class _MagneticLetterState extends State<_MagneticLetter> {
  final GlobalKey _key = GlobalKey();
  Offset _center = Offset.zero;

  @override
  void initState() {
    super.initState();
    // Update center position after layout
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateCenter());
  }

  void _updateCenter() {
    if (!mounted) return;
    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      setState(() {
        _center = position + Offset(size.width / 2, size.height / 2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Recalculate center on resize/scroll if needed, but for now assume static layout or simple resize
    // For a robust solution, we might want to listen to scroll notifications or resize events.
    // But for a Hero section that is usually 100vh, it's mostly static.

    return Consumer<MouseProvider>(
      builder: (context, mouse, child) {
        if (_center == Offset.zero) {
          // Try to update if we haven't yet (e.g. first frame)
          WidgetsBinding.instance.addPostFrameCallback((_) => _updateCenter());
        }

        final mousePos = mouse.position;
        final dx = mousePos.dx - _center.dx;
        final dy = mousePos.dy - _center.dy;
        final distance =
            (dx * dx + dy * dy); // Squared distance for performance

        // Interaction radius (e.g., 300 pixels)
        const double radius = 300.0;
        const double radiusSq = radius * radius;

        double moveX = 0;
        double moveY = 0;

        if (distance < radiusSq) {
          // Calculate force - stronger when closer
          final double force = (1 - (distance / radiusSq)) * widget.strength;
          moveX = dx * force * 0.2; // 0.2 is a dampening factor
          moveY = dy * force * 0.2;
        }

        return Transform.translate(
          offset: Offset(moveX, moveY),
          child: Text(widget.character, key: _key, style: widget.style),
        );
      },
    );
  }
}
