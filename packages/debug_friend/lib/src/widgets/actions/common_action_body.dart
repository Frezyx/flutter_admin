import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/theme/defaults.dart';
import 'package:flutter/material.dart';

class CommonActionBody extends StatelessWidget {
  const CommonActionBody({
    Key? key,
    required this.child,
    required this.theme,
    this.margin,
  }) : super(key: key);

  final DebugFriendTheme theme;
  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: margin ?? const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: defaultShadow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
