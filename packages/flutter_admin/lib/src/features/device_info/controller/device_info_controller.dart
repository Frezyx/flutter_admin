import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoController extends ChangeNotifier {
  static final _deviceInfoPlug = DeviceInfoPlugin();

  PackageInfo? _packageInfo;
  var _deviceInfo = <String, dynamic>{};

  PackageInfo? get packageInfo => _packageInfo;
  Map<String, dynamic> get deviceInfo => _deviceInfo;

  Future<void> load() async {
    await _loadPackageInfo();
    await _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final inf = await _deviceInfoPlug.androidInfo;
          _deviceInfo = inf.data;
          break;
        case TargetPlatform.iOS:
          final inf = await _deviceInfoPlug.iosInfo;
          _deviceInfo = inf.data;
          break;
        case TargetPlatform.linux:
          final inf = await _deviceInfoPlug.linuxInfo;
          _deviceInfo = inf.data;
          break;
        case TargetPlatform.macOS:
          final inf = await _deviceInfoPlug.macOsInfo;
          _deviceInfo = inf.data;
          break;
        case TargetPlatform.windows:
          final inf = await _deviceInfoPlug.windowsInfo;
          _deviceInfo = inf.data;
          break;
        case TargetPlatform.fuchsia:
          break;
      }
      notifyListeners();
    } on Exception catch (_) {
      // options.talker.handle(e, st);
    }
  }

  Future<void> _loadPackageInfo() async {
    try {
      _packageInfo = await PackageInfo.fromPlatform();
      notifyListeners();
    } on Exception catch (_) {
      // options.talker.handle(e, st);
    }
  }
}
