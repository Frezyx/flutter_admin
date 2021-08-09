import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class CommonActionHeader extends StatelessWidget {
  const CommonActionHeader({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [Defaults.getShadow(theme)],
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 15),
        child: icon,
      ),
    );
  }
}
