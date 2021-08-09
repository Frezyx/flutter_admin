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
        decoration: BoxDecoration(
          color: theme.canvasColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              blurRadius: 5,
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: icon,
      ),
    );
  }
}
