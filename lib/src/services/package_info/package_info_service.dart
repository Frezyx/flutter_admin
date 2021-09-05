import 'package:package_info_plus/package_info_plus.dart';

abstract class PackageInfoService {
  static Future<PackageInfo> getInfo() {
    return PackageInfo.fromPlatform();
  }
}
