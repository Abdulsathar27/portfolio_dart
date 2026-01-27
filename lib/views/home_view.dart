import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/home_provider.dart';
import 'package:profitillo/views/sections/about_section.dart';
import 'package:profitillo/views/sections/contact_section.dart';
import 'package:profitillo/views/sections/experience_section.dart';
import 'package:profitillo/views/sections/hero_section.dart';
import 'package:profitillo/views/sections/projects_section.dart';
import 'package:profitillo/views/sections/skills_section.dart';
import 'package:profitillo/views/widgets/floating_nav_bar.dart';
import 'package:profitillo/views/widgets/footer.dart';
import 'package:profitillo/views/widgets/mobile_drawer.dart';
import 'package:profitillo/views/widgets/responsive_wrapper.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      endDrawer: const MobileDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: homeProvider.scrollController,
            child: Column(
              children: [
                HeroSection(key: homeProvider.heroKey),
                AboutSection(key: homeProvider.aboutMeKey),
                ExperienceSection(key: homeProvider.experienceKey),
                ProjectsSection(key: homeProvider.projectsKey),
                SkillsSection(key: homeProvider.skillsKey),
                ContactSection(key: homeProvider.contactKey),
                const Footer(),
              ],
            ),
          ),
          if (ResponsiveWrapper.isDesktop(context))
            const Positioned(top: 0, left: 0, right: 0, child: FloatingNavBar())
          else
            Positioned(
              top: 20,
              right: 20,
              child: Builder(
                builder: (context) => IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).cardColor.withValues(alpha: 0.8),
                  ),
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
