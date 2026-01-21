import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/core/constants/app_colors.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/widgets/custom_button.dart';
import 'package:profitillo/widgets/responsive_wrapper.dart';
import 'package:profitillo/widgets/animated_background.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:profitillo/widgets/magnetic_text.dart';
import 'package:profitillo/widgets/animated_role_tag.dart';
import 'package:profitillo/providers/navigation_provider.dart';
import 'package:profitillo/core/utils/web_utils.dart';
import 'package:profitillo/widgets/interactive_illustration.dart';

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
          style: GoogleFonts.outfit(
            fontSize: 24,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),

        const SizedBox(height: 10),

        MagneticText(
              text: AppStrings.name,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: ResponsiveWrapper.isDesktop(context) ? 90 : 56,
                height: 1.0,
                color: Theme.of(context).textTheme.displayLarge?.color,
                shadows: [
                  Shadow(
                    color: AppColors.primary.withOpacity(0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              strength: 0.8,
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideX(begin: -0.1, end: 0),

        const SizedBox(height: 20),

        const AnimatedRoleTag(),

        const SizedBox(height: 20),

        Text(
              AppStrings.tagline,
              style: GoogleFonts.outfit(
                color: AppColors.textSecondary,
                fontSize: 25,
                height: 1.6,
                fontWeight: FontWeight.w300,
              ),
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideX(begin: -0.1, end: 0),

        const SizedBox(height: 40),

        Row(
              children: [
                CustomButton(
                  text: "View Projects",
                  onPressed: () {
                    final navProvider = Provider.of<NavigationProvider>(
                      context,
                      listen: false,
                    );
                    navProvider.scrollTo(navProvider.projectsKey);
                  },
                ),
                const SizedBox(width: 20),
                CustomButton(
                  text: "View Resume",
                  onPressed: () {
                    openFileInNewTab('assets/resume/Abdul_Sathar_Resume.pdf');
                  },
                  isOutlined: true,
                  icon: Icons.visibility,
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
    return const InteractiveIllustration();
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
