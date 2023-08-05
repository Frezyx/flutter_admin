import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum FlutterAdminViewType {
  expanded,
  collapsed,
  hiden,
  disabled,
}

class FlutterAdminBarController extends ChangeNotifier {
  FlutterAdminBarController() {
    _initPackageInfo();
  }

  var _viewType = FlutterAdminViewType.collapsed;
  var _barHeight = defaultBarHeight;
  PackageInfo? _packageInfo;

  Future<void> _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }

  PackageInfo? get packageInfo => _packageInfo;

  static const defaultBarHeight = 60.0;

  double get barHeight => _barHeight;
  set barHeight(double val) {
    _barHeight = val;
    notifyListeners();
  }

  FlutterAdminViewType get viewType => _viewType;
  set viewType(FlutterAdminViewType val) {
    _viewType = val;
    notifyListeners();
  }
}
