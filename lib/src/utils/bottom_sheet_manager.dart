import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class BottomSheetManager {
  BottomSheetManager({
    required this.items,
    required this.commonItems,
  });
  final List<Widget> items;
  final List<Widget> commonItems;

  void showDebugMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const DebugMenu(
          items: [],
          commonItems: [],
        );
      },
    );
  }
}
