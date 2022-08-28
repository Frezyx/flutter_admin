import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

abstract class ImageManager {
  static Future<void> pickAndSave() async {
    final image = await _pick();
    await _save(image);
  }

  static Future<File> _pick() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    final File image = File(pickedFile!.path);
    return image;
  }

  static Future<void> _save(File image) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    final rnd = Random().nextInt(1000);
    await image.copy('$path/$rnd${DateTime.now().toIso8601String()}.png');
  }
}
