import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class CommonActionBody extends StatelessWidget {
  const CommonActionBody({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [Defaults.getShadow(theme)],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: child,
    );
  }
}
