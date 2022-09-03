import 'package:debug_friend/src/theme/defaults.dart';
import 'package:debug_friend/src/theme/theme.dart';
import 'package:flutter/material.dart';

class CommonActionHeader extends StatelessWidget {
  const CommonActionHeader({
    Key? key,
    required this.icon,
    this.selected = false,
  }) : super(key: key);

  final Widget icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: selected ? theme.primaryColor : theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: defaultShadow,
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10),
      child: icon,
    );
  }
}
