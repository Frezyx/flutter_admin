import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.onTap,
    required this.icon,
    this.title,
  }) : super(key: key);

  final Widget icon;
  final String? title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CommonActionHeader(icon: icon),
          if (title != null) const SizedBox(width: 10),
          if (title != null) Text(title!),
        ],
      ),
    );
  }
}
