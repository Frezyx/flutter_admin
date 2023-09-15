import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_admin/src/services/services.dart';

class DeviceDataController extends ChangeNotifier {
  final _fileService = FileService();

  var _files = <File>[];
  List<File> get files => _files;

  Future<void> loadFilesList() async {
    try {
      final f = await _fileService.loadAppFiles();
      _files = f;
      notifyListeners();
    } on Exception {
      // talker.handle(e, st);
    }
  }

  Future<void> deleteFile(int index) async {
    try {
      await _files[index].delete();
      await loadFilesList();
    } on Exception {
      // talker.handle(e, st);
    }
  }

  Future<void> deleteFiles() async {
    try {
      for (final file in _files) {
        await file.delete();
      }
      await loadFilesList();
    } on Exception {
      // talker.handle(e, st);
    }
  }
}
