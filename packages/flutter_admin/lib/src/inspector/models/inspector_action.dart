import 'package:flutter/material.dart';

class InspectorAction {
  const InspectorAction({
    this.title,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  final String? title;
  final Widget icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InspectorAction &&
        other.title == title &&
        other.icon == icon &&
        other.onTap == onTap &&
        other.selected == selected;
  }

  @override
  int get hashCode {
    return title.hashCode ^ icon.hashCode ^ onTap.hashCode ^ selected.hashCode;
  }
}
