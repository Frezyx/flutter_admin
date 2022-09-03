import 'dart:io';

import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/services/device_info/service.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoBody extends StatefulWidget {
  const DeviceInfoBody({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final DebugFriendTheme theme;

  @override
  _DeviceInfoBodyState createState() => _DeviceInfoBodyState();
}

class _DeviceInfoBodyState extends State<DeviceInfoBody> {
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  @override
  void initState() {
    if (Platform.isIOS) {
      _setIosInfo();
    } else if (Platform.isAndroid) {
      _setAndroidInfo();
    }
    super.initState();
  }

  Future<void> _setIosInfo() async {
    final d = await DeviceInfoService.getIos();
    setState(() => _iosDeviceInfo = d);
  }

  Future<void> _setAndroidInfo() async {
    final d = await DeviceInfoService.getAndroid();
    setState(() => _androidDeviceInfo = d);
  }

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (_androidDeviceInfo != null) {
      child = _AndroidInfoBody(
        androidDeviceInfo: _androidDeviceInfo!,
        theme: widget.theme,
      );
    } else if (_iosDeviceInfo != null) {
      child = _IosInfoBody(
        iosDeviceInfo: _iosDeviceInfo!,
        theme: widget.theme,
      );
    } else {
      child = const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Device info',
            style: widget.theme.headerStyle,
          ),
        ),
        CommonActionBody(
          theme: widget.theme,
          child: child,
        ),
      ],
    );
  }
}

class _AndroidInfoBody extends StatelessWidget {
  const _AndroidInfoBody({
    Key? key,
    required AndroidDeviceInfo androidDeviceInfo,
    required this.theme,
  })  : _deviceInfo = androidDeviceInfo,
        super(key: key);

  final DebugFriendTheme theme;
  final AndroidDeviceInfo _deviceInfo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyValueLine(
            k: 'Device:',
            v: _deviceInfo.device ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Model:',
            v: _deviceInfo.model ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Product:',
            v: _deviceInfo.product ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Version:',
            v: _deviceInfo.version.release ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Version codename:',
            v: _deviceInfo.version.codename ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Version incremental:',
            v: _deviceInfo.version.incremental ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Version securityPatch:',
            v: _deviceInfo.version.securityPatch ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Version previewSdkInt:',
            v: '${_deviceInfo.version.previewSdkInt}',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Version baseOS:',
            v: _deviceInfo.version.baseOS ?? '',
            theme: theme,
          ),

          // KeyValueLine(k: 'Identifier fro vendor:', v: _di.identifierForVendor),
          // KeyValueLine(k: 'Localized model:', v: _di.localizedModel),
          KeyValueLine(
            k: 'Device foundation:',
            v: (_deviceInfo.isPhysicalDevice ?? false)
                ? 'Physical'
                : 'Emulator',
            theme: theme,
          ),
        ]
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _IosInfoBody extends StatelessWidget {
  const _IosInfoBody({
    Key? key,
    required IosDeviceInfo iosDeviceInfo,
    required this.theme,
  })  : _deviceInfo = iosDeviceInfo,
        super(key: key);

  final IosDeviceInfo _deviceInfo;
  final DebugFriendTheme theme;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyValueLine(
            k: 'Model:',
            v: _deviceInfo.model ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Name:',
            v: _deviceInfo.name ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'System name:',
            v: _deviceInfo.systemName ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'System version:',
            v: _deviceInfo.systemVersion ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Identifier fro vendor:',
            v: _deviceInfo.identifierForVendor ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Localized model:',
            v: _deviceInfo.localizedModel ?? '',
            theme: theme,
          ),
          KeyValueLine(
            k: 'Device foundation:',
            v: _deviceInfo.isPhysicalDevice ? 'Physical' : 'Emulator',
            theme: theme,
          ),
        ]
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
