import 'package:flutter/material.dart';

class InspectorAction {
  InspectorAction({
    this.title,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  final String? title;
  final Widget icon;
  final VoidCallback onTap;
  final bool selected;
}
