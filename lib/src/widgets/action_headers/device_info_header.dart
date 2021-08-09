import 'package:debug_friend/src/widgets/action_headers/action_headers.dart';
import 'package:flutter/material.dart';

class DeviceInfoHeader extends StatelessWidget {
  const DeviceInfoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonActionHeader(
      icon: const Icon(Icons.devices),
      onTap: () {},
    );
  }
}
