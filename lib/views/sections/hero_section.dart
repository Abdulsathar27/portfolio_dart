import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:provider/provider.dart';

import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/views/widgets/custom_button.dart';
import 'package:profitillo/views/widgets/responsive_wrapper.dart';
import 'package:profitillo/views/widgets/animated_background.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:profitillo/views/widgets/magnetic_text.dart';
import 'package:profitillo/views/widgets/animated_role_tag.dart';
import 'package:profitillo/providers/home_provider.dart';
import 'package:profitillo/core/utils/web_utils.dart';
import 'package:profitillo/views/widgets/interactive_illustration.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveWrapper.isDesktop(context);

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ResponsiveWrapper(
                mobile: _buildMobileLayout(context),
                tablet: _buildTabletLayout(context),
                desktop: _buildDesktopLayout(context),
              ),
            ),
          ),
          if (isDesktop)
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _buildTextContent(context, centered: false)),
        const SizedBox(width: 40),
        Expanded(flex: 2, child: _buildIllustration(context)),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: _buildTextContent(context, centered: false),
            ),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildIllustration(context)),
          ],
        ),
        const SizedBox(height: 60),
        const _ScrollIndicator(),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIllustration(context),
        const SizedBox(height: 40),
        _buildTextContent(context, centered: true),
        const SizedBox(height: 60),
        const _ScrollIndicator(),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {required bool centered}) {
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    final crossAlign = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final isMobile = ResponsiveWrapper.isMobile(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAlign,
      children: [
        Text(
          "Hello, I'm",
          style: GoogleFonts.outfit(
            fontSize: isMobile ? 18 : 24,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
          textAlign: textAlign,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),

        const SizedBox(height: 10),

        MagneticText(
              text: AppStrings.name,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: _getNameFontSize(context),
                height: 1.0,
                color: Theme.of(context).textTheme.displayLarge?.color,
                shadows: [
                  Shadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.3),
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
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontSize: _getTaglineFontSize(context),
                height: 1.6,
                fontWeight: FontWeight.w300,
              ),
              textAlign: textAlign,
            )
            .animate()
            .fadeIn(delay: 600.ms, duration: 800.ms, curve: Curves.easeOut)
            .slideX(begin: -0.1, end: 0),

        const SizedBox(height: 40),

        _buildButtons(context, isMobile: isMobile),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, {required bool isMobile}) {
    final navProvider = Provider.of<HomeProvider>(context, listen: false);
    final viewProjectsBtn = CustomButton(
      text: "View Projects",
      onPressed: () {
        navProvider.scrollTo(navProvider.projectsKey);
      },
      width: isMobile ? double.infinity : null,
    );
    final viewResumeBtn = CustomButton(
      text: "View Resume",
      onPressed: () {
        openFileInNewTab('resume.pdf');
      },
      isOutlined: true,
      icon: Icons.visibility,
      width: isMobile ? double.infinity : null,
    );

    if (isMobile) {
      return Column(
            children: [
              viewProjectsBtn,
              const SizedBox(height: 16),
              viewResumeBtn,
            ],
          )
          .animate()
          .fadeIn(delay: 800.ms, duration: 800.ms, curve: Curves.easeOut)
          .slideY(begin: 0.2, end: 0);
    }

    return Row(
          children: [viewProjectsBtn, const SizedBox(width: 20), viewResumeBtn],
        )
        .animate()
        .fadeIn(delay: 800.ms, duration: 800.ms, curve: Curves.easeOut)
        .slideY(begin: 0.2, end: 0);
  }

  double _getNameFontSize(BuildContext context) {
    if (ResponsiveWrapper.isDesktop(context)) return 90;
    if (ResponsiveWrapper.isTablet(context)) return 70;
    return 48;
  }

  double _getTaglineFontSize(BuildContext context) {
    if (ResponsiveWrapper.isDesktop(context)) return 25;
    if (ResponsiveWrapper.isTablet(context)) return 22;
    return 18;
  }

  Widget _buildIllustration(BuildContext context) {
    return const InteractiveIllustration();
  }
}

class _ScrollIndicator extends StatelessWidget {
  const _ScrollIndicator();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.height < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isSmallScreen) ...[
          Text(
            "Scroll Down",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
        ],
        Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).colorScheme.primary,
              size: isSmallScreen ? 24 : 30,
            )
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
