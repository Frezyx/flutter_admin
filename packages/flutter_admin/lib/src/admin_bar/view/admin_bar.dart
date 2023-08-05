import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';

class FlutterAdminBar extends StatelessWidget {
  const FlutterAdminBar({
    Key? key,
    required this.talker,
    required this.adminTheme,
    this.height = 60,
    this.borderRadius = BorderRadius.zero,
    required this.controller,
  }) : super(key: key);

  final Talker talker;
  final FlutterAdminTheme adminTheme;
  final double height;
  final BorderRadius borderRadius;
  final FlutterAdminBarController controller;

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
      decoration: BoxDecoration(color: adminTheme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                          onPressed: () => _openLogs(context),
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
                            ...data.whereType<TalkerException>()
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
                  Text(
                    'v4.5.66',
                    style: adminTheme.subtitleText,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openLogs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: adminTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return TalkerView(
            talker: talker,
            scrollController: scrollController,
            theme: TalkerScreenTheme(
              backgroundColor: adminTheme.backgroundColor,
            ),
          );
        },
      ),
    );
  }

  void _hideMenuBar() {
    controller.viewType = FlutterAdminViewType.hiden;
  }
}
