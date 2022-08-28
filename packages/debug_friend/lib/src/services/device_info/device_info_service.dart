import 'package:device_info_plus/device_info_plus.dart';

mixin DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<AndroidDeviceInfo> getAndroid() async {
    return _deviceInfo.androidInfo;
  }

  static Future<IosDeviceInfo> getIos() async {
    return _deviceInfo.iosInfo;
  }
}
