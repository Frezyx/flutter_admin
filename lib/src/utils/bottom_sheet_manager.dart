import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

abstract class BottomSheetManager {
  static void showDebugMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return DebugMenu(
          items: [],
        );
      },
    );
  }
}
