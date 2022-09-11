import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

class FlutterAdminBar extends StatelessWidget {
  const FlutterAdminBar({
    Key? key,
    required this.theme,
    this.height = 60,
  }) : super(key: key);

  final FlutterAdminTheme theme;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(color: theme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                color: theme.lightCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
