import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class BottomSheetManager {
  BottomSheetManager({
    required this.items,
    required this.commonItems,
  });
  final List<Widget> items;
  final List<Widget> commonItems;

  void showDebugMenu(
    BuildContext context, {
    List<ActionCard>? customActionCards,
  }) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (ctx) {
        return DebugFriendMenu(
          headers: const [
            // DeviceInfoHeader(),
            PackageInfoHeader(),
            AppDataHeader(),
            AppActionsHeader(),
            // CustomActionHeader(),
          ],
          bodies: [
            Expanded(
              child: ListView(
                children: const [
                  SizedBox(height: 10),
                  DeviceInfoBody(),
                  SizedBox(height: 10),
                  PackageInfoBody(),
                ],
              ),
            ),
            // const PackageInfoBody(),
            const AppDataBody(),
            AppActionsBody(
              cards: customActionCards,
            ),
          ],
        );
      },
    );
  }
}
