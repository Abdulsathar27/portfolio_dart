import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InteractiveSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const InteractiveSocialIcon({
    super.key,
    required this.icon,
    required this.url,
  });

  @override
  State<InteractiveSocialIcon> createState() => _InteractiveSocialIconState();
}

class _InteractiveSocialIconState extends State<InteractiveSocialIcon> {
  final ValueNotifier<bool> _isHovering = ValueNotifier(false);
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);

  @override
  void dispose() {
    _isHovering.dispose();
    _mousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovering.value = true,
      onExit: (_) {
        _isHovering.value = false;
        _mousePos.value = Offset.zero;
      },
      onHover: (event) {
        if (!mounted) return;
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final center = box.size.center(Offset.zero);
        final localPos = box.globalToLocal(event.position);
        _mousePos.value = localPos - center;
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: _isHovering,
          builder: (context, isHovering, child) {
            return ValueListenableBuilder<Offset>(
              valueListenable: _mousePos,
              builder: (context, mousePos, _) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.identity()
                    ..translate(
                      isHovering ? mousePos.dx * 0.3 : 0.0,
                      isHovering ? mousePos.dy * 0.3 : 0.0,
                    )
                    ..scale(isHovering ? 1.2 : 1.0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isHovering
                        ? Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isHovering
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      if (isHovering)
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: FaIcon(
                    widget.icon,
                    size: 20,
                    color: isHovering
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
