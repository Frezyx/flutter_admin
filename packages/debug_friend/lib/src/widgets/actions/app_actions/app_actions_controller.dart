import 'dart:io';

import 'package:debug_friend/src/utils/talker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as r;

class AppActionsController extends ChangeNotifier {
  var _debugDisableOpacityLayers = false;
  bool get debugDisableOpacityLayers => _debugDisableOpacityLayers;
  void toggleDebugDisableOpacityLayers() {
    r.debugDisableOpacityLayers = !r.debugDisableOpacityLayers;
    _debugDisableOpacityLayers = r.debugDisableOpacityLayers;
    notifyListeners();
  }

  var _debugDisablePhysicalShapeLayers = false;
  bool get debugDisablePhysicalShapeLayers => _debugDisablePhysicalShapeLayers;
  void toggleDebugDisablePhysicalShapeLayers() {
    r.debugDisablePhysicalShapeLayers = !r.debugDisablePhysicalShapeLayers;
    _debugDisablePhysicalShapeLayers = r.debugDisablePhysicalShapeLayers;
    notifyListeners();
  }

  var _debugDisableClipLayers = false;
  bool get debugDisableClipLayers => _debugDisableClipLayers;
  void toggleDebugDisableClipLayers() {
    r.debugDisableClipLayers = !r.debugDisableClipLayers;
    _debugDisableClipLayers = r.debugDisableClipLayers;
    notifyListeners();
  }

  var _debugRepaintTextRainbowEnabled = false;
  bool get debugRepaintTextRainbowEnabled => _debugRepaintTextRainbowEnabled;
  void toggleDebugRepaintTextRainbowEnabled() {
    r.debugRepaintTextRainbowEnabled = !r.debugRepaintTextRainbowEnabled;
    _debugRepaintTextRainbowEnabled = r.debugRepaintTextRainbowEnabled;
    notifyListeners();
  }

  var _debugRepaintRainbowEnabled = false;
  bool get debugRepaintRainbowEnabled => _debugRepaintRainbowEnabled;
  void toggleDebugRepaintRainbowEnabled() {
    r.debugRepaintRainbowEnabled = !r.debugRepaintRainbowEnabled;
    _debugRepaintRainbowEnabled = r.debugRepaintRainbowEnabled;
    notifyListeners();
  }

  var _debugPaintLayerBordersEnabled = false;
  bool get debugPaintLayerBordersEnabled => _debugPaintLayerBordersEnabled;
  void toggleDebugPaintLayerBordersEnabled() {
    r.debugPaintLayerBordersEnabled = !r.debugPaintLayerBordersEnabled;
    _debugPaintLayerBordersEnabled = r.debugPaintLayerBordersEnabled;
    notifyListeners();
  }

  var _debugPaintBaselinesEnabled = false;
  bool get debugPaintBaselinesEnabled => _debugPaintBaselinesEnabled;
  void toggleDebugPaintBaselinesEnabled() {
    r.debugPaintBaselinesEnabled = !r.debugPaintBaselinesEnabled;
    _debugPaintBaselinesEnabled = r.debugPaintBaselinesEnabled;
    notifyListeners();
  }

  var _debugPaintSizeEnabled = false;
  bool get debugPaintSizeEnabled => _debugPaintSizeEnabled;
  void toggleDebugPaintSizeEnabled() {
    r.debugPaintSizeEnabled = !r.debugPaintSizeEnabled;
    _debugPaintSizeEnabled = r.debugPaintSizeEnabled;
    notifyListeners();
  }

  void exitApp() {
    try {
      exit(0);
    } on Exception catch (e, st) {
      talker.handle(e, st);
    }
  }
}
