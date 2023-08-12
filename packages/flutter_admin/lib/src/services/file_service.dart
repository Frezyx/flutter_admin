import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<List<File>> loadAppFiles() async {
    final fileModels = <File>[];
    final cacheDir = await getTemporaryDirectory();
    final files = cacheDir.listSync();
    for (final file in files) {
      final fileModel = File(file.path);
      fileModels.add(fileModel);
    }
    return fileModels;
  }
}
