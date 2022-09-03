import 'package:debug_friend/src/theme/defaults.dart';
import 'package:flutter/material.dart';

class CommonActionBody extends StatelessWidget {
  const CommonActionBody({
    Key? key,
    required this.child,
    this.margin,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
