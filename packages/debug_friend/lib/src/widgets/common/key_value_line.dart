import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class KeyValueLine extends StatelessWidget {
  const KeyValueLine({
    Key? key,
    required this.k,
    required this.v,
    required this.theme,
  }) : super(key: key);

  final String k;
  final String v;
  final DebugFriendTheme theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            k,
            style: theme.bodyText,
          ),
        ),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              v,
              textAlign: TextAlign.end,
              style: theme.bodyText,
            ),
          ),
        ),
      ],
    );
  }
}
