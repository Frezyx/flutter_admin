import 'package:flutter/material.dart';

enum FlutterAdminViewType { expanded, hiden }

class FlutterAdminBarController extends ChangeNotifier {
  FlutterAdminBarController();

  var _barShowing = false;
  var _barHeight = defaultBarHeight;

  static const defaultBarHeight = 60.0;

  double get barHeight => _barHeight;
  set barHeight(double val) {
    _barHeight = val;
    notifyListeners();
  }

  bool get barShowing => _barShowing;
  void hideBar() {
    _barShowing = true;
    notifyListeners();
  }

  void showBar() {
    _barShowing = false;
    notifyListeners();
  }

  void toggleExpanded(double expandedHeight) {
    if (_barHeight == defaultBarHeight) {
      _barHeight = expandedHeight;
    } else {
      _barHeight = defaultBarHeight;
    }
    notifyListeners();
  }
}
