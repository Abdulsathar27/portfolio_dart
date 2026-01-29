import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Provider for managing animation states across the application
/// Stores hover states, offset states, and numeric values for animations
/// Widgets consume this via Consumer/Selector and render animations declaratively
class AnimationStateProvider extends ChangeNotifier {
  // Hover states (for hover animations)
  final Map<String, bool> _hoverStates = {};

  // Offset states (for magnetic/parallax effects)
  final Map<String, Offset> _offsetStates = {};

  // Numeric states (for progress, scale, etc.)
  final Map<String, double> _numericStates = {};

  // ===== HOVER STATE MANAGEMENT =====

  /// Get hover state for a widget by ID
  bool isHovering(String id) => _hoverStates[id] ?? false;

  /// Set hover state for a widget
  void setHover(String id, bool value) {
    if (_hoverStates[id] != value) {
      _hoverStates[id] = value;
      notifyListeners();
    }
  }

  /// Clear hover state for a widget
  void clearHover(String id) {
    if (_hoverStates.remove(id) != null) {
      notifyListeners();
    }
  }

  // ===== OFFSET STATE MANAGEMENT =====

  /// Get offset state for a widget by ID
  Offset getOffset(String id) => _offsetStates[id] ?? Offset.zero;

  /// Set offset state for a widget
  void setOffset(String id, Offset value) {
    if (_offsetStates[id] != value) {
      _offsetStates[id] = value;
      notifyListeners();
    }
  }

  /// Clear offset state for a widget
  void clearOffset(String id) {
    if (_offsetStates.remove(id) != null) {
      notifyListeners();
    }
  }

  // ===== NUMERIC STATE MANAGEMENT =====

  /// Get numeric state for a widget by ID
  double getNumeric(String id, {double defaultValue = 0.0}) =>
      _numericStates[id] ?? defaultValue;

  /// Set numeric state for a widget
  void setNumeric(String id, double value) {
    if (_numericStates[id] != value) {
      _numericStates[id] = value;
      notifyListeners();
    }
  }

  /// Clear numeric state for a widget
  void clearNumeric(String id) {
    if (_numericStates.remove(id) != null) {
      notifyListeners();
    }
  }

  // ===== CLEANUP =====

  /// Clear all states for a specific widget ID
  void clearAllStates(String id) {
    bool changed = false;
    if (_hoverStates.remove(id) != null) changed = true;
    if (_offsetStates.remove(id) != null) changed = true;
    if (_numericStates.remove(id) != null) changed = true;
    if (changed) notifyListeners();
  }

  /// Clear all animation states (useful for cleanup)
  void clearAll() {
    _hoverStates.clear();
    _offsetStates.clear();
    _numericStates.clear();
    notifyListeners();
  }
}
