import 'dart:io';

import 'package:debug_friend/src/services/file/service.dart';
import 'package:debug_friend/src/utils/talker.dart';
import 'package:flutter/foundation.dart';

class AppDataController extends ChangeNotifier {
  var _files = <File>[];
  List<File> get files => _files;

  Future<void> loadFilesList() async {
    try {
      final f = await FileService.instance.getFiles();
      _files = f;
      notifyListeners();
    } on Exception catch (e, st) {
      talker.handle(e, st);
    }
  }

  Future<void> deleteFile(int index) async {
    try {
      await _files[index].delete();
      await loadFilesList();
    } on Exception catch (e, st) {
      talker.handle(e, st);
    }
  }

  Future<void> deleteFiles() async {
    try {
      for (final file in _files) {
        await file.delete();
      }
      await loadFilesList();
    } on Exception catch (e, st) {
      talker.handle(e, st);
    }
  }
}
