import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/utils/utils.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Wraps your application in the debug friend zone
///
/// {@tool snippet}
///
/// This sample shows how to define an app with a plugin.
///
/// ```dart
///DebugFriendView(
///  builder: (context) {
///    return const Scaffold(
///      body: Text('Your app home widget'),
///    );
///  },
/// ),
/// ```
/// {@end-tool}
class DebugFriendView extends StatelessWidget {
  DebugFriendView({
    Key? key,
    this.icon = const Icon(Icons.bug_report),
    required this.builder,
    this.enabled = kDebugMode,
    this.customActions,
  })  : _bottomSheetManager = BottomSheetManager(
          items: [],
          commonItems: [],
        ),
        super(key: key);

  /// Widget that displayed at DebugFriend action header
  final Widget icon;

  /// Should return your application widget for which DebugFriend is applied
  final WidgetBuilder builder;

  /// When this field is [true] - debug friend is running in your app
  /// in other case - [DebugFriendButton] going sleep
  /// By default this field get value from const [kDebugMode]
  final bool enabled;

  /// Custom actions menu items
  /// They are shown on the 4th page of the menu
  final List<ActionCard>? customActions;

  final BottomSheetManager _bottomSheetManager;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return builder(context);
    }
    return Material(
      child: Stack(
        children: [
          builder(context),
          DebugFriendButton(
            onTap: () {
              _bottomSheetManager.showDebugMenu(
                context,
                customActionCards: customActions,
              );
            },
            child: icon,
          ),
        ],
      ),
    );
  }
}
