import 'package:flutter/material.dart';

abstract class Defaults {
  static BoxShadow getShadow(ThemeData theme) {
    return BoxShadow(
      color: theme.shadowColor.withOpacity(0.12),
      blurRadius: 25,
      offset: const Offset(0, 5),
    );
  }
}
