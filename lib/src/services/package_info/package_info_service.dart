import 'package:package_info/package_info.dart';

abstract class PackageInfoService {
  static Future<PackageInfo> getInfo() {
    return PackageInfo.fromPlatform();
  }
}
