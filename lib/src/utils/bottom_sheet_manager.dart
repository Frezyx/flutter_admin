import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

abstract class BottomSheetManager {
  static void showDebugMenu(BuildContext context) {
    print('Show');
    showBottomSheet(
      context: context,
      builder: (ctx) {
        return DebugMenu();
      },
    );
  }
}
