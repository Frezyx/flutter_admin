import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    Key? key,
    required this.adminTheme,
    required this.child,
  }) : super(key: key);

  final FlutterAdminTheme adminTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: adminTheme.lightCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
