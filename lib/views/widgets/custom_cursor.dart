import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/mouse_provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';

class CustomCursor extends StatefulWidget {
  const CustomCursor({super.key});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Offset _currentPos = Offset.zero;
  Offset _targetPos = Offset.zero;

  // Physics constants
  static const double _speed = 25.0; // Higher = snappier/faster

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (!mounted) return;

    // Get latest target from provider without listening (we just want the value)
    final provider = context.read<MouseProvider>();
    _targetPos = provider.position;

    // If we're effectively at the target, don't waste CPU
    // (using a small epsilon for float comparison)
    if ((_targetPos - _currentPos).distanceSquared < 0.1) {
      if (_currentPos != _targetPos) {
        setState(() {
          _currentPos = _targetPos;
        });
      }
      return;
    }

    // Time-based lerp for smooth movement independent of frame rate
    // Using a fixed delta approximation since Ticker gives total elapsed time
    // A simplified frame-based smooth damp is often robust enough for cursors:
    // current = current + (target - current) * factor
    // Factor derived from time: 1 - exp(-speed * dt)
    // Assuming 60fps ~ 16ms, 120fps ~ 8ms.
    // We can use a simpler approach since Ticker.elapsed is cumulative.

    // Calculate standard dt (delta time)
    // Since createTicker doesn't give us dt directly in a simple way without state,
    // we'll assume a standard frame budget or calculate it?
    // standard 'lerp' logic `a + (b - a) * t` is frame-rate dependent if `t` is fixed.
    // To be frame-rate independent: t = 1 - pow(decay, dt)
    // For simplicity and performance in UI loop:

    const double dt =
        1.0 / 60.0; // Approximation or calculate real delta if needed
    // Ideally we track last elapsed.

    // Correct independent approach:
    // offset += (target - offset) * (1 - exp(-speed * dt))

    final double smoothFactor = 1 - math.exp(-_speed * dt); // ~0.34 at speed 25

    setState(() {
      _currentPos += (_targetPos - _currentPos) * smoothFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    // We listen to the provider mainly for hover state changes or initial position
    return Consumer<MouseProvider>(
      builder: (context, provider, child) {
        // The dot follows immediate provider position (no lag)
        // The ring follows _currentPos (smooth lag)

        return IgnorePointer(
          child: Stack(
            children: [
              // Main Ring (Smooth Follower)
              Positioned(
                left:
                    _currentPos.dx - (provider.isHoveringInteractive ? 20 : 10),
                top:
                    _currentPos.dy - (provider.isHoveringInteractive ? 20 : 10),
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

              // Trailing/Center Pointer Dot (Immediate)
              Positioned(
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
