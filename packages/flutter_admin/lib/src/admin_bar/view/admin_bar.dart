import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';

class FlutterAdminBar extends StatelessWidget {
  const FlutterAdminBar({
    Key? key,
    required this.talker,
    required this.adminTheme,
    this.borderRadius = BorderRadius.zero,
    required this.controller,
    required this.expandedHeigh,
    required this.onLogsTap,
  }) : super(key: key);

  final Talker talker;
  final FlutterAdminTheme adminTheme;

  final BorderRadius borderRadius;
  final FlutterAdminBarController controller;

  final double expandedHeigh;

  final VoidCallback onLogsTap;

  @override
  Widget build(BuildContext context) {
    final enabledBar = controller.viewType != FlutterAdminViewType.hiden &&
        controller.viewType != FlutterAdminViewType.disabled;
    if (!enabledBar) {
      return const SizedBox();
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      height: controller.barHeight,
      width: double.infinity,
      decoration: BoxDecoration(color: adminTheme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8).copyWith(right: 0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                color: adminTheme.lightCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: _hideMenuBar,
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: adminTheme.iconTheme.color,
                        ),
                      ),
                      TalkerBuilder(
                        talker: talker,
                        builder: (context, data) => TextButton(
                          onPressed: onLogsTap,
                          child: RichText(
                            text: TextSpan(
                              text: '${data.length} ',
                              style: const TextStyle(color: Colors.green),
                              children: const [
                                TextSpan(
                                  text: 'Logs',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TalkerBuilder(
                        talker: talker,
                        builder: (context, data) {
                          final errors = [
                            ...data.whereType<TalkerError>(),
                            ...data.where(
                              (e) =>
                                  e.runtimeType == TalkerError ||
                                  e.logLevel == LogLevel.error ||
                                  e.logLevel == LogLevel.critical,
                            ),
                          ];
                          return TextButton(
                            onPressed: () {},
                            child: RichText(
                              text: TextSpan(
                                text: '${errors.length} ',
                                style: const TextStyle(color: Colors.red),
                                children: const [
                                  TextSpan(
                                    text: 'Errors',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _toggleExpanded,
                    child: Text(
                      '${controller.packageInfo?.appName ?? ''} '
                      'v${controller.packageInfo?.version ?? 'x.x.x'}',
                      style: adminTheme.subtitleText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggleExpanded() {
    controller.toggleExpanded(expandedHeigh);
  }

  void _hideMenuBar() {
    controller.viewType = FlutterAdminViewType.hiden;
  }
}
