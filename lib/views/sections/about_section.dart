import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:profitillo/core/constants/app_assets.dart';
import 'package:profitillo/core/constants/app_strings.dart';
import 'package:profitillo/views/widgets/responsive_wrapper.dart';
import 'package:profitillo/views/widgets/theme_aware_card.dart';
import 'package:profitillo/views/widgets/highlight_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: ResponsiveWrapper(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildProfileImage(context)),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildContent(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileImage(context),
        const SizedBox(height: 40),
        _buildContent(context),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return ThemeAwareCard(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              AppAssets.profile, // Replace with actual image
              fit: BoxFit.cover,
              height: 400,
              width: double.infinity,
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, curve: Curves.easeOut)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Text(
              AppStrings.aboutMe,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),

        const SizedBox(height: 20),

        Text(
              "More than just code.",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            )
            .animate()
            .fadeIn(delay: 200.ms, duration: 800.ms)
            .slideX(begin: -0.1, end: 0),

        const SizedBox(height: 30),

        _buildParagraph(
          context,
          "I believe that great software is about more than just writing clean lines of code—it's about creating intuitive, seamless experiences that solve real problems.",
          delay: 400,
        ),

        const SizedBox(height: 20),

        _buildParagraph(
          context,
          "With a background in generic engineering and a passion for design, I bridge the gap between technical complexity and visual elegance.",
          delay: 600,
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            const Text("Specializing in: "),
            HighlightText(
              text: "Flutter",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text(", "),
            HighlightText(
              text: "Dart",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text(", and "),
            HighlightText(
              text: "Clean Architecture",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text("."),
          ],
        ).animate().fadeIn(delay: 800.ms, duration: 800.ms),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildParagraph(
    BuildContext context,
    String text, {
    required int delay,
  }) {
    return Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 800.ms,
        )
        .slideX(begin: -0.05, end: 0);
  }

  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
