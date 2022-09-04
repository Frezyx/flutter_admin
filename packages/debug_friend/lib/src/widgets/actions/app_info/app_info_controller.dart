import 'package:debug_friend/src/utils/talker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoController extends ChangeNotifier {
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;
  PackageInfo? _packageInfo;

  PackageInfo? get packageInfo => _packageInfo;
  IosDeviceInfo? get iosDeviceInfo => _iosDeviceInfo;
  AndroidDeviceInfo? get androidDeviceInfo => _androidDeviceInfo;

  Future<void> loadAll() async {
    await _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
      notifyListeners();
    } on Exception catch (e, st) {
      talker.handle(e, st);
    }
  }
}
