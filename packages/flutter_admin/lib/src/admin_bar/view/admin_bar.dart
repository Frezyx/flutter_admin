import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/admin_bar/view/widgets/widgets.dart';

class FlutterAdminBar extends StatelessWidget {
  const FlutterAdminBar({
    Key? key,
    required this.talker,
    required this.adminTheme,
    this.borderRadius = BorderRadius.zero,
    required this.controller,
    required this.expandedHeigh,
    required this.onLogsTap,
    required this.onErrorsTap,
    required this.onHttpTap,
  }) : super(key: key);

  final Talker talker;
  final FlutterAdminTheme adminTheme;

  final BorderRadius borderRadius;
  final FlutterAdminBarController controller;

  final double expandedHeigh;

  final VoidCallback onLogsTap;
  final VoidCallback onErrorsTap;
  final VoidCallback onHttpTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: controller.barShowing ? controller.barHeight : 0,
      width: double.infinity,
      decoration: BoxDecoration(color: adminTheme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
                      const VerticalDivider(width: 1),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12)
                          .copyWith(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _LogsButton(
                            talker: talker,
                            adminTheme: adminTheme,
                            onTap: onLogsTap,
                          ),
                          _ErrorsButton(
                            talker: talker,
                            adminTheme: adminTheme,
                            onTap: onErrorsTap,
                          ),
                          _HttpButton(
                            adminTheme: adminTheme,
                            onTap: onHttpTap,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const VerticalDivider(width: 1),
                      IconButton(
                        onPressed: _toggleExpanded,
                        icon: Icon(
                          Icons.expand_less,
                          size: 32,
                          color: adminTheme.iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleExpanded() => controller.toggleExpanded(expandedHeigh);

  void _hideMenuBar() => controller.hideBar();
}

class _HttpButton extends StatelessWidget {
  const _HttpButton({
    Key? key,
    required this.adminTheme,
    required this.onTap,
  }) : super(key: key);

  final FlutterAdminTheme adminTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BarButton(
      adminTheme: adminTheme,
      onPressed: onTap,
      child: RichText(
        text: const TextSpan(
          text: '21 ',
          style: TextStyle(
            color: Colors.green,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: 'Http',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorsButton extends StatelessWidget {
  const _ErrorsButton({
    Key? key,
    required this.talker,
    required this.adminTheme,
    required this.onTap,
  }) : super(key: key);

  final Talker talker;
  final FlutterAdminTheme adminTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TalkerErrorsBuilder(
      talker: talker,
      builder: (context, errors) {
        return BarButton(
          adminTheme: adminTheme,
          onPressed: onTap,
          child: RichText(
            text: TextSpan(
              text: '${errors.length} ',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              children: const [
                TextSpan(
                  text: 'Error',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LogsButton extends StatelessWidget {
  const _LogsButton({
    Key? key,
    required this.talker,
    required this.adminTheme,
    required this.onTap,
  }) : super(key: key);

  final Talker talker;
  final FlutterAdminTheme adminTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TalkerBuilder(
      talker: talker,
      builder: (context, data) => BarButton(
        adminTheme: adminTheme,
        onPressed: onTap,
        child: RichText(
          text: TextSpan(
            text: '${data.length} ',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            children: const [
              TextSpan(
                text: 'Log',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
