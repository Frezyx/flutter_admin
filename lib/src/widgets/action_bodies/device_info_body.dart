import 'dart:io';

import 'package:debug_friend/src/services/device_info/service.dart';
import 'package:debug_friend/src/widgets/action_bodies/action_bodies.dart';
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
  })  : _iosDeviceInfo = iosDeviceInfo,
        super(key: key);

  final IosDeviceInfo _iosDeviceInfo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_iosDeviceInfo.model),
          Text(_iosDeviceInfo.name),
          Text(_iosDeviceInfo.systemName),
          Text(_iosDeviceInfo.systemVersion),
          Text(_iosDeviceInfo.identifierForVendor),
          Text(_iosDeviceInfo.localizedModel),
          Text(_iosDeviceInfo.isPhysicalDevice ? 'Physical' : 'Emulator'),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
