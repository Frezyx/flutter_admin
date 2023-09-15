import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as r;

class InspectorController extends ChangeNotifier {
  var _debugDisableOpacityLayers = false;
  bool get debugDisableOpacityLayers => _debugDisableOpacityLayers;

  void toggleDebugDisableOpacityLayers() {
    _debugDisableOpacityLayers =
        r.debugDisableOpacityLayers = !r.debugDisableOpacityLayers;

    notifyListeners();
  }

  var _debugDisablePhysicalShapeLayers = false;
  bool get debugDisablePhysicalShapeLayers => _debugDisablePhysicalShapeLayers;

  void toggleDebugDisablePhysicalShapeLayers() {
    _debugDisablePhysicalShapeLayers =
        r.debugDisablePhysicalShapeLayers = !r.debugDisablePhysicalShapeLayers;

    notifyListeners();
  }

  var _debugDisableClipLayers = false;
  bool get debugDisableClipLayers => _debugDisableClipLayers;

  void toggleDebugDisableClipLayers() {
    _debugDisableClipLayers =
        r.debugDisableClipLayers = !r.debugDisableClipLayers;
    notifyListeners();
  }

  var _debugRepaintTextRainbowEnabled = false;
  bool get debugRepaintTextRainbowEnabled => _debugRepaintTextRainbowEnabled;

  void toggleDebugRepaintTextRainbowEnabled() {
    _debugRepaintTextRainbowEnabled =
        r.debugRepaintTextRainbowEnabled = !r.debugRepaintTextRainbowEnabled;
    notifyListeners();
  }

  var _debugRepaintRainbowEnabled = false;
  bool get debugRepaintRainbowEnabled => _debugRepaintRainbowEnabled;

  void toggleDebugRepaintRainbowEnabled() {
    _debugRepaintRainbowEnabled =
        r.debugRepaintRainbowEnabled = !r.debugRepaintRainbowEnabled;
    notifyListeners();
  }

  var _debugPaintLayerBordersEnabled = false;
  bool get debugPaintLayerBordersEnabled => _debugPaintLayerBordersEnabled;

  void toggleDebugPaintLayerBordersEnabled() {
    _debugPaintLayerBordersEnabled =
        r.debugPaintLayerBordersEnabled = !r.debugPaintLayerBordersEnabled;
    notifyListeners();
  }

  var _debugPaintBaselinesEnabled = false;
  bool get debugPaintBaselinesEnabled => _debugPaintBaselinesEnabled;

  void toggleDebugPaintBaselinesEnabled() {
    _debugPaintBaselinesEnabled =
        r.debugPaintBaselinesEnabled = !r.debugPaintBaselinesEnabled;
    notifyListeners();
  }

  var _debugPaintSizeEnabled = false;
  bool get debugPaintSizeEnabled => _debugPaintSizeEnabled;

  void toggleDebugPaintSizeEnabled() {
    _debugPaintSizeEnabled = r.debugPaintSizeEnabled = !r.debugPaintSizeEnabled;
    notifyListeners();
  }

  void exitApp() {
    exit(0);
  }
}
