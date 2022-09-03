import 'package:flutter/material.dart';

class DebugFriendTheme {
  const DebugFriendTheme({
    this.primaryColor = Colors.purple,
    this.backgroundColor = const Color(0xFF1E1F28),
    this.cardColor = const Color(0xFF2A2C36),
    this.lightCardColor = const Color(0xFF3C3E4E),
    this.bodyText = const TextStyle(color: Colors.white, fontSize: 16),
    this.headerStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    this.subtitleText = const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
  });

  final Color primaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color lightCardColor;
  final TextStyle bodyText;
  final TextStyle subtitleText;
  final TextStyle headerStyle;

  factory DebugFriendTheme.fromFlutterTheme(BuildContext context) {
    final t = Theme.of(context);
    return DebugFriendTheme(
      primaryColor: t.primaryColor,
      backgroundColor: t.backgroundColor,
      cardColor: t.cardColor,
      lightCardColor: t.canvasColor,
    );
  }
}
