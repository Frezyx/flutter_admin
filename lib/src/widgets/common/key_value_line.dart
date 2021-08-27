import 'package:flutter/material.dart';

class KeyValueLine extends StatelessWidget {
  const KeyValueLine({
    Key? key,
    required this.k,
    required this.v,
  }) : super(key: key);

  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(k)),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(v, textAlign: TextAlign.end),
          ),
        ),
      ],
    );
  }
}
