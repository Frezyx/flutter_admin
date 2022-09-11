import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/controller/controller.dart';

class FlutterAdminBar extends StatelessWidget {
  const FlutterAdminBar({
    Key? key,
    required this.theme,
    this.height = 60,
    this.borderRadius = BorderRadius.zero,
    required this.controller,
  }) : super(key: key);

  final FlutterAdminTheme theme;
  final double height;
  final BorderRadius borderRadius;
  final FlutterAdminController controller;

  @override
  Widget build(BuildContext context) {
    final enabledBar = controller.viewType != FlutterAdminViewType.hiden &&
        controller.viewType != FlutterAdminViewType.disabled;
    if (!enabledBar) {
      return const SizedBox();
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(color: theme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                color: theme.lightCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.viewType = FlutterAdminViewType.hiden;
                    },
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: theme.iconTheme.color,
                    ),
                  ),
                  Text(
                    'application v4.5.66',
                    style: theme.subtitleText,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
