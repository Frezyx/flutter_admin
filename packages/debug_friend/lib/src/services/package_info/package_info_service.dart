import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  PackageInfoService._();
  static Future<PackageInfo> getInfo() {
    return PackageInfo.fromPlatform();
  }
}
