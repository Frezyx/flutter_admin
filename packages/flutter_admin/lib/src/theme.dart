import 'package:flutter/material.dart';

class FlutterAdminTheme {
  const FlutterAdminTheme({
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
    this.iconTheme = const IconThemeData(color: Colors.white),
  });

  final Color primaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color lightCardColor;
  final TextStyle bodyText;
  final TextStyle subtitleText;
  final TextStyle headerStyle;
  final IconThemeData iconTheme;

  factory FlutterAdminTheme.fromFlutterTheme(BuildContext context) {
    final t = Theme.of(context);
    return FlutterAdminTheme(
      primaryColor: t.primaryColor,
      backgroundColor: t.canvasColor,
      cardColor: t.cardColor,
      lightCardColor: t.canvasColor,
    );
  }
}