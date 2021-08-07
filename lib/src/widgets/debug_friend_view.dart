import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DebugFriendView extends StatelessWidget {
  const DebugFriendView({
    Key? key,
    required this.icon,
    required this.builder,
    this.color,
    this.enabled = kDebugMode,
  }) : super(key: key);

  /// Widget that displayed at main Button
  final Widget icon;

  /// Color of debug button
  final Color? color;

  /// Your app
  final WidgetBuilder builder;

  /// When this field is [true] - debug friend is running in your app
  /// in other case - [DebugFriendButton] going sleep
  /// By default this field get value from const [kDebugMode]
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return builder(context);
    }
    return Scaffold(
      body: Stack(
        children: [
          builder(context),
          DebugFriendButton(
            child: icon,
          ),
        ],
      ),
    );
  }
}
