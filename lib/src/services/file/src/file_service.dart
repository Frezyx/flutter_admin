import 'package:debug_friend/src/services/file/service.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements AbstractFileService {
  FileService._();

  static final AbstractFileService _service = FileService._();
  static AbstractFileService get instance => _service;

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
