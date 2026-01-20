import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/navigation_provider.dart';
import 'package:profitillo/sections/about_section.dart';
import 'package:profitillo/sections/contact_section.dart';
import 'package:profitillo/sections/experience_section.dart';
import 'package:profitillo/sections/hero_section.dart';
import 'package:profitillo/sections/projects_section.dart';
import 'package:profitillo/sections/skills_section.dart';
import 'package:profitillo/widgets/floating_nav_bar.dart';
import 'package:profitillo/widgets/footer.dart';
import 'package:profitillo/widgets/mobile_drawer.dart';
import 'package:profitillo/widgets/responsive_wrapper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    return Scaffold(
      endDrawer: const MobileDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(key: navProvider.heroKey),
                AboutSection(key: navProvider.aboutMeKey),
                ExperienceSection(key: navProvider.experienceKey),
                ProjectsSection(key: navProvider.projectsKey),
                SkillsSection(key: navProvider.skillsKey),
                ContactSection(key: navProvider.contactKey),
                const Footer(),
              ],
            ),
          ),
          if (ResponsiveWrapper.isDesktop(context))
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FloatingNavBar(scrollController: _scrollController),
            )
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
