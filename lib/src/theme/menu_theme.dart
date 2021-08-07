import 'package:flutter/material.dart';

class MenuTheme {
  const MenuTheme({required this.backgroundColor});

  final Color backgroundColor;

  const MenuTheme.base()
      : this(
          backgroundColor: Colors.white,
        );
}
