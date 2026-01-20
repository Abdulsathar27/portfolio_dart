import 'package:flutter/material.dart';

class MouseProvider extends ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isHoveringInteractive = false;

  Offset get position => _position;
  bool get isHoveringInteractive => _isHoveringInteractive;

  void updatePosition(Offset position) {
    _position = position;
    notifyListeners();
  }

  void setHoveringInteractive(bool isHovering) {
    if (_isHoveringInteractive != isHovering) {
      _isHoveringInteractive = isHovering;
      notifyListeners();
    }
  }
}
