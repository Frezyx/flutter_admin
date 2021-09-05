import 'package:debug_friend/src/theme/theme.dart';
import 'package:flutter/material.dart';

class CommonActionHeader extends StatelessWidget {
  const CommonActionHeader({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [Defaults.getShadow(theme)],
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      child: icon,
    );
  }
}
