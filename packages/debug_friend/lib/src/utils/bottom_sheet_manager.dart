import 'package:flutter/material.dart';

class BottomSheetManager {
  BottomSheetManager();

  void showBottomSheet(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: builder,
    );
  }
}
