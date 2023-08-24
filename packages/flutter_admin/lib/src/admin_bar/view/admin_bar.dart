import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/admin_bar/view/widgets/widgets.dart';
import 'package:flutter_admin/src/device_info/device_info.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class FlutterAdminBar extends StatelessWidget {
  const FlutterAdminBar({
    Key? key,
    this.borderRadius = BorderRadius.zero,
    required this.controller,
    required this.expandedHeigh,
    required this.onLogsTap,
    required this.onErrorsTap,
    required this.onHttpTap,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final FlutterAdminBarController controller;

  final double expandedHeigh;

  final VoidCallback onLogsTap;
  final VoidCallback onErrorsTap;
  final VoidCallback onHttpTap;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: controller.barShowing ? controller.barHeight : 0,
      width: double.infinity,
      decoration: BoxDecoration(color: options.theme.backgroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                color: options.theme.lightCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _hideMenuBar,
                      child: BaseCard(
                        adminTheme: options.theme,
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          size: 28,
                          color: options.theme.iconTheme.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12)
                            .copyWith(top: 16),
                        child: SizedBox(
                          height: 28,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _LogsButton(onTap: onLogsTap),
                              const SizedBox(width: 8),
                              _ErrorsButton(onTap: onErrorsTap),
                              const SizedBox(width: 8),
                              _HttpButton(onTap: onHttpTap),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _toggleExpanded,
                      child: BaseCard(
                        adminTheme: options.theme,
                        child: Icon(
                          Icons.expand_less,
                          size: 28,
                          color: options.theme.iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: FlutterAdminBarController.defaultBarHeight,
              ),
              child: SizedBox(
                height: controller.barHeight -
                    FlutterAdminBarController.defaultBarHeight,
                child: const DeviceInfoView(),
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
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return BarButton(
      adminTheme: options.theme,
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
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return TalkerErrorsBuilder(
      talker: options.talker,
      builder: (context, errors) {
        return BarButton(
          adminTheme: options.theme,
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
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return TalkerBuilder(
      talker: options.talker,
      builder: (context, data) => BarButton(
        adminTheme: options.theme,
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
