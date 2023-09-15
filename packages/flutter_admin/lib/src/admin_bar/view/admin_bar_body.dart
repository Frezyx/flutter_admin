import 'package:flutter/material.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/admin_bar/view/widgets/widgets.dart';
import 'package:flutter_admin/src/features/device_data/device_data.dart';
import 'package:flutter_admin/src/features/device_info/device_info.dart';
import 'package:flutter_admin/src/features/inspector/view/inspector_view.dart';
import 'package:flutter_admin/src/features/network/view/network_view.dart';
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
              actions: const [
                AdminBarAction(
                  title: 'Device',
                  icon: Icons.app_settings_alt,
                ),
                AdminBarAction(
                  title: 'Data',
                  icon: Icons.folder_open,
                ),
                AdminBarAction(
                  title: 'Network',
                  icon: Icons.wifi,
                ),
                AdminBarAction(
                  title: 'Inspector',
                  icon: Icons.touch_app,
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  DeviceInfoView(),
                  DeviceDataView(),
                  NetworkView(),
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
