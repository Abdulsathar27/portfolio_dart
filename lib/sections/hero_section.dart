import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/widgets/custom_button.dart';
import 'package:profitillo/widgets/responsive_wrapper.dart';
import 'package:profitillo/widgets/animated_background.dart';
import 'package:profitillo/providers/mouse_provider.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height, 
      child: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ResponsiveWrapper(
                mobile: _buildMobileLayout(context),
                desktop: _buildDesktopLayout(context),
              ),
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: _ScrollIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 3, child: _buildTextContent(context)),
        const SizedBox(width: 40),
        Expanded(flex: 2, child: _buildIllustration(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIllustration(context),
        const SizedBox(height: 40),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello, I'm",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),

        const SizedBox(height: 10),

        Text(
              AppStrings.name,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: ResponsiveWrapper.isDesktop(context) ? 80 : 48,
                height: 1.1,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withOpacity(0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideX(begin: -0.1, end: 0)
            .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.2)),

        Text(
              AppStrings.title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideX(begin: -0.1, end: 0),

        const SizedBox(height: 20),

        Text(
              AppStrings.tagline,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 18,
                height: 1.5,
              ),
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideX(begin: -0.1, end: 0),

        const SizedBox(height: 40),

        Row(
              children: [
                CustomButton(text: "View Projects", onPressed: () {}),
                const SizedBox(width: 20),
                CustomButton(
                  text: "Download Resume",
                  onPressed: () {},
                  isOutlined: true,
                  icon: Icons.download,
                ),
              ],
            )
            .animate()
            .fadeIn(delay: 800.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildIllustration(BuildContext context) {
    return Consumer<MouseProvider>(
      builder: (context, mouse, child) {
        // Parallax effect
        final parallaxX =
            (mouse.position.dx - MediaQuery.of(context).size.width / 2) * 0.02;
        final parallaxY =
            (mouse.position.dy - MediaQuery.of(context).size.height / 2) * 0.02;

        return Transform.translate(
          offset: Offset(parallaxX, parallaxY),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.primary.withOpacity(0.0),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Floating elements
                _FloatingIcon(
                  icon: Icons.code,
                  size: 80,
                  color: AppColors.primary,
                  offset: const Offset(-50, -50),
                  delay: 0,
                ),
                _FloatingIcon(
                  icon: Icons.flutter_dash,
                  size: 60,
                  color: Colors.blue,
                  offset: const Offset(60, -20),
                  delay: 1000,
                ),
                _FloatingIcon(
                  icon: Icons.phone_android,
                  size: 50,
                  color: Colors.green,
                  offset: const Offset(-20, 60),
                  delay: 2000,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final Offset offset;
  final int delay;

  const _FloatingIcon({
    required this.icon,
    required this.size,
    required this.color,
    required this.offset,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child:
          Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(icon, size: size, color: color),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .moveY(
                begin: -10,
                end: 10,
                duration: 3000.ms,
                curve: Curves.easeInOut,
                delay: Duration(milliseconds: delay),
              ),
    );
  }
}

class _ScrollIndicator extends StatelessWidget {
  const _ScrollIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Scroll Down",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 30)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .moveY(
              begin: -5,
              end: 5,
              duration: 1000.ms,
              curve: Curves.easeInOut,
            ),
      ],
    );
  }
}
