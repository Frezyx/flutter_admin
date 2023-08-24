import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/device_info/controller/device_info_controller.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class DeviceInfoView extends StatefulWidget {
  const DeviceInfoView({Key? key}) : super(key: key);

  @override
  State<DeviceInfoView> createState() => _DeviceInfoViewState();
}

class _DeviceInfoViewState extends State<DeviceInfoView> {
  final _deviceInfoController = DeviceInfoController();

  @override
  void initState() {
    _deviceInfoController.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Package info',
              style: options.theme.headerStyle,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: AnimatedBuilder(
            animation: _deviceInfoController,
            builder: (context, _) {
              final pi = _deviceInfoController.packageInfo;
              if (pi == null) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BaseCard(
                    adminTheme: options.theme,
                    child: Column(
                      children: [
                        KeyValueRow(
                          k: 'App name:',
                          v: pi.appName,
                        ),
                        KeyValueRow(
                          k: 'Vaerion:',
                          v: pi.version,
                        ),
                        KeyValueRow(
                          k: 'Build number:',
                          v: pi.buildNumber,
                        ),
                        KeyValueRow(
                          k: 'Package name:',
                          v: pi.packageName,
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Device info',
              style: options.theme.headerStyle,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: AnimatedBuilder(
            animation: _deviceInfoController,
            builder: (context, _) {
              final deviceInfo = _deviceInfoController.deviceInfo;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BaseCard(
                  adminTheme: options.theme,
                  child: Column(
                    children: deviceInfo.entries
                        .map(
                            (e) => KeyValueRow(k: e.key, v: e.value.toString()))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
