import 'package:flutter/material.dart';

class DebugFlutterTheme {
  const DebugFlutterTheme({
    this.backgroundColor = const Color(0xFF1E1F28),
    this.cardColor = const Color(0xFF2A2C36),
    this.lightCardColor = const Color(0xFF3C3E4E),
  });

  final Color backgroundColor;
  final Color cardColor;
  final Color lightCardColor;

  factory DebugFlutterTheme.fromFlutterTheme(BuildContext context) {
    final t = Theme.of(context);
    return DebugFlutterTheme(
      backgroundColor: t.backgroundColor,
      cardColor: t.cardColor,
      lightCardColor: t.canvasColor,
    );
  }
}
