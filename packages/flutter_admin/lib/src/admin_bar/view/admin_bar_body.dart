import 'package:flutter/material.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/admin_bar/view/widgets/widgets.dart';
import 'package:flutter_admin/src/features/device_data/device_data.dart';
import 'package:flutter_admin/src/features/device_info/device_info.dart';
import 'package:flutter_admin/src/features/inspector/view/inspector_view.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';
import 'package:group_button/group_button.dart';

class AdminBarBody extends StatefulWidget {
  const AdminBarBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final FlutterAdminBarController controller;

  @override
  State<AdminBarBody> createState() => _AdminBarBodyState();
}

class _AdminBarBodyState extends State<AdminBarBody> {
  final _pageController = PageController();
  final _groupButtonController = GroupButtonController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FlutterAdminBarController.defaultBarHeight,
      ),
      child: SizedBox(
        height: widget.controller.barHeight -
            FlutterAdminBarController.defaultBarHeight,
        child: Column(
          children: [
            AdminBarPageSelector(
              onSelected: _setActiveIndex,
              controller: _groupButtonController,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  DeviceInfoView(),
                  DeviceDataView(),
                  InspectorView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setActiveIndex(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }
}

class AdminBarPageSelector extends StatelessWidget {
  const AdminBarPageSelector({
    Key? key,
    required this.onSelected,
    required this.controller,
  }) : super(key: key);

  final GroupButtonController controller;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return SizedBox(
      height: 44,
      child: ListView(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        children: [
          GroupButton<AdminBarAction>(
            controller: controller,
            isRadio: true,
            buttons: const [
              AdminBarAction(
                title: 'Device',
                icon: Icons.app_settings_alt,
              ),
              AdminBarAction(
                title: 'Data',
                icon: Icons.folder_open,
              ),
              AdminBarAction(
                title: 'Inspector',
                icon: Icons.touch_app,
              ),
            ],
            onSelected: (_, index, __) => onSelected(index),
            buttonBuilder: (selected, e, context) {
              return BarButton(
                backgroundColor:
                    selected ? Theme.of(context).primaryColor : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      e.icon,
                      color: options.theme.iconTheme.color,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      e.title,
                      style: options.theme.bodyText.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AdminBarAction {
  const AdminBarAction({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}
