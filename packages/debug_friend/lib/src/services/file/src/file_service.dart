import 'dart:io';

import 'package:debug_friend/src/services/file/service.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements AbstractFileService {
  static final AbstractFileService _service = FileService._();
  static AbstractFileService get instance => _service;

  @override
  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  @override
  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  @override
  Future<List<File>> getFiles() async {
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
