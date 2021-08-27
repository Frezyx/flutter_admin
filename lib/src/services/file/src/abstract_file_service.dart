import 'dart:io';

abstract class AbstractFileService {
  Future<void> deleteCacheDir();
  Future<void> deleteAppDir();
  Future<List<File>> getFiles();
}
