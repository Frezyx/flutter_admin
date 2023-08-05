import 'package:flutter/material.dart';

enum FlutterAdminViewType {
  expanded,
  collapsed,
  hiden,
  disabled,
}

class FlutterAdminBarController extends ChangeNotifier {
  static const defaultBarHeight = 60.0;

  var _barHeight = defaultBarHeight;
  double get barHeight => _barHeight;
  set barHeight(double val) {
    _barHeight = val;
    notifyListeners();
  }

  var _viewType = FlutterAdminViewType.collapsed;
  FlutterAdminViewType get viewType => _viewType;
  set viewType(FlutterAdminViewType val) {
    _viewType = val;
    notifyListeners();
  }
}
