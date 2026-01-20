import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutMeKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  Future<void> scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }
}
