import 'package:device_info/device_info.dart';

mixin DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<AndroidDeviceInfo> getAndroid() async {
    return _deviceInfo.androidInfo;
  }

  static Future<IosDeviceInfo> getIos() async {
    return _deviceInfo.iosInfo;
  }
}
