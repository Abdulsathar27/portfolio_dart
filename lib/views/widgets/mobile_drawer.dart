import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/providers/home_provider.dart';
import 'package:profitillo/core/constants/app_strings.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<HomeProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                AppStrings.name,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(AppStrings.aboutMe),
            onTap: () {
              Navigator.pop(context);
              navProvider.scrollTo(navProvider.aboutMeKey);
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text(AppStrings.projects),
            onTap: () {
              Navigator.pop(context);
              navProvider.scrollTo(navProvider.projectsKey);
            },
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text(AppStrings.skills),
            onTap: () {
              Navigator.pop(context);
              navProvider.scrollTo(navProvider.skillsKey);
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: const Text(AppStrings.contact),
            onTap: () {
              Navigator.pop(context);
              navProvider.scrollTo(navProvider.contactKey);
            },
          ),
        ],
      ),
    );
  }
}
