import 'dart:io';

import 'package:debug_friend/src/services/device_info/service.dart';
import 'package:debug_friend/src/widgets/action_bodies/action_bodies.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class DeviceInfoBody extends StatefulWidget {
  const DeviceInfoBody({Key? key}) : super(key: key);

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
      //TODO: implement android
      child = const SizedBox();
    } else if (_iosDeviceInfo != null) {
      child = _IosInfoBody(
        iosDeviceInfo: _iosDeviceInfo!,
      );
    } else {
      child = const SizedBox();
    }

    return CommonActionBody(
      child: child,
    );
  }
}

class _IosInfoBody extends StatelessWidget {
  const _IosInfoBody({
    Key? key,
    required IosDeviceInfo iosDeviceInfo,
  })  : _di = iosDeviceInfo,
        super(key: key);

  final IosDeviceInfo _di;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyValueLine(k: 'Model:', v: _di.model),
          KeyValueLine(k: 'Name:', v: _di.name),
          KeyValueLine(k: 'System name:', v: _di.systemName),
          KeyValueLine(k: 'System version:', v: _di.systemVersion),
          KeyValueLine(k: 'Identifier fro vendor:', v: _di.identifierForVendor),
          KeyValueLine(k: 'Localized model:', v: _di.localizedModel),
          KeyValueLine(
              k: 'Device foundation:',
              v: _di.isPhysicalDevice ? 'Physical' : 'Emulator'),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
