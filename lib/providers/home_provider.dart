import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool _isNavBarVisible = true;
  bool get isNavBarVisible => _isNavBarVisible;
  double _lastScrollOffset = 0;

  HomeProvider() {
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final currentOffset = scrollController.offset;
    if (currentOffset > _lastScrollOffset && currentOffset > 50) {
      if (_isNavBarVisible) {
        _isNavBarVisible = false;
        notifyListeners();
      }
    } else {
      if (!_isNavBarVisible) {
        _isNavBarVisible = true;
        notifyListeners();
      }
    }
    _lastScrollOffset = currentOffset;
  }

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutMeKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
