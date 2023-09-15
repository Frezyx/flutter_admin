import 'package:flutter/foundation.dart';

class NetworkController extends ChangeNotifier {
  num _sentBytes = 0;
  num _receivedBytes = 0;

  num get sentBytes => _sentBytes;
  num get receivedBytes => _receivedBytes;

  set sentBytes(num bytes) {
    _sentBytes = bytes;
    notifyListeners();
  }

  set receivedBytes(num bytes) {
    _receivedBytes = bytes;
    notifyListeners();
  }
}
