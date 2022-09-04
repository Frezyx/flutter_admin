import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/actions/app_info/app_info.dart';
import 'package:debug_friend/src/widgets/actions/app_info/app_info_controller.dart';
import 'package:flutter/material.dart';

class AppInfoBody extends StatefulWidget {
  const AppInfoBody({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final DebugFriendTheme theme;

  @override
  State<AppInfoBody> createState() => _AppInfoBodyState();
}

class _AppInfoBodyState extends State<AppInfoBody> {
  final _contorller = AppInfoController();

  @override
  void initState() {
    _contorller.loadAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _contorller,
      builder: (context, _) {
        return Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 10),
              DeviceInfoBody(
                theme: widget.theme,
                androidDeviceInfo: _contorller.androidDeviceInfo,
                iosDeviceInfo: _contorller.iosDeviceInfo,
              ),
              const SizedBox(height: 10),
              PackageInfoBody(
                theme: widget.theme,
                packageInfo: _contorller.packageInfo,
              ),
            ],
          ),
        );
      },
    );
  }
}
