import 'package:flutter/material.dart';

class DebugFriendTheme {
  const DebugFriendTheme({
    this.primaryColor = Colors.purple,
    this.backgroundColor = const Color(0xFF1E1F28),
    this.cardColor = const Color(0xFF2A2C36),
    this.lightCardColor = const Color(0xFF3C3E4E),
  });

  final Color primaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color lightCardColor;

  factory DebugFriendTheme.fromFlutterTheme(BuildContext context) {
    final t = Theme.of(context);
    return DebugFriendTheme(
      backgroundColor: t.backgroundColor,
      cardColor: t.cardColor,
      lightCardColor: t.canvasColor,
    );
  }
}
