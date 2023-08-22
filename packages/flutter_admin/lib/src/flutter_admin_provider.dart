import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

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
  }) {
    _talker = talker ?? TalkerFlutter.init();
  }

  final FlutterAdminTheme theme;
  late final Talker _talker;

  Talker get talker => _talker;
}
