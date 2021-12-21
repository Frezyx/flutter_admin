import 'package:flutter/material.dart';

class Defaults {
  Defaults._();

  static BoxShadow getShadow(ThemeData theme) {
    return BoxShadow(
      color: theme.shadowColor.withOpacity(0.12),
      blurRadius: 25,
      offset: const Offset(0, 5),
    );
  }
}
