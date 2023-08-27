import 'package:flutter/material.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    Key? key,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: options.theme.lightCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
