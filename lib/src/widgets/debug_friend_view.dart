import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class DebugFriendView extends StatelessWidget {
  const DebugFriendView({
    Key? key,
    this.color,
    required this.icon,
    required this.child,
  }) : super(key: key);

  /// Widget that displayed at main Button
  final Widget icon;

  /// Color of debug button
  final Color? color;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          DebugFriend(
            child: icon,
          ),
        ],
      ),
    );
  }
}
