import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedRepository {
  late SharedPreferences _prefs;

  final _controller = StreamController<List<int>>();
  Stream<List<int>> get stream => _controller.stream;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _controller.add(await getValues());
  }

  Future<void> addValue(int value) async {
    _prefs.setInt(DateTime.now().toIso8601String(), value);
    _controller.add(await getValues());
  }

  Future<void> deleteValues() async {
    final keys = _prefs.getKeys();
    for (final key in keys) {
      _prefs.remove(key);
    }
    _controller.add([]);
  }

  Future<List<int>> getValues() async {
    final values = <int>[];
    final keys = _prefs.getKeys();
    for (final key in keys) {
      values.add(_prefs.getInt(key)!);
    }
    return values;
  }

  Future<void> dispose() async {
    _controller.close();
  }
}
