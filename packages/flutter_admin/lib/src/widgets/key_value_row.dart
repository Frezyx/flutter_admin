import 'package:flutter/material.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({
    Key? key,
    required this.k,
    required this.v,
  }) : super(key: key);

  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(k, style: options.theme.bodyText),
        ),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              v,
              textAlign: TextAlign.end,
              style: options.theme.bodyText,
            ),
          ),
        ),
      ],
    );
  }
}
