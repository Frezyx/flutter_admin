import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/services/dio/dio.dart';

class FlutterAdminProvider extends InheritedWidget {
  const FlutterAdminProvider({
    Key? key,
    required Widget child,
    required this.options,
  }) : super(key: key, child: child);

  final FlutterAdminOptions options;

  static FlutterAdminOptions of(BuildContext context) {
    final contextTheme =
        context.dependOnInheritedWidgetOfExactType<FlutterAdminProvider>();
    if (contextTheme != null) {
      return contextTheme.options;
    }
    return FlutterAdminOptions();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return options != (oldWidget as FlutterAdminProvider).options;
  }
}

class FlutterAdminOptions {
  FlutterAdminOptions({
    this.theme = const FlutterAdminTheme(),
    Talker? talker,
    this.dio,
  }) {
    _talker = talker ?? TalkerFlutter.init();
  }

  final FlutterAdminTheme theme;
  late final Talker _talker;
  final Dio? dio;

  Talker get talker => _talker;

  void init() {
    dio?.interceptors.add(DioAnalyserInterceptor());
  }
}
