import 'dart:io';

import 'package:debug_friend/src/services/file/service.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements AbstractFileService {
  FileService._();

  static final AbstractFileService _service = FileService._();
  static AbstractFileService get instance => _service;

  @override
  Future<void> deleteAppDir() => _deleteAppDir();

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  @override
  Future<void> deleteCacheDir() => _deleteCacheDir();

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  @override
  Future<List<File>> getFiles() => _getFilesList();

  Future<List<File>> _getFilesList() async {
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
