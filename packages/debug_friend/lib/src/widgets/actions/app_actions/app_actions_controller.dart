import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as r;

class AppActionsController extends ChangeNotifier {
  var _debugDisableOpacityLayers = false;
  bool get debugDisableOpacityLayers => _debugDisableOpacityLayers;
  void toggleDebugDisableOpacityLayers() {
    r.debugDisableOpacityLayers = !r.debugDisableOpacityLayers;
    _debugDisableOpacityLayers = r.debugDisableOpacityLayers;
  }
}
