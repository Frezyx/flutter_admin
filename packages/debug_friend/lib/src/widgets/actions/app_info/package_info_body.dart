import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoBody extends StatelessWidget {
  const PackageInfoBody({
    Key? key,
    required this.theme,
    this.packageInfo,
  }) : super(key: key);

  final DebugFriendTheme theme;
  final PackageInfo? packageInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Package info',
            style: theme.headerStyle,
          ),
        ),
        CommonActionBody(
          theme: theme,
          child: SizedBox(
            width: double.infinity,
            child: _PackageInfoBody(
              packageInfo: packageInfo,
              theme: theme,
            ),
          ),
        ),
      ],
    );
  }
}

class _PackageInfoBody extends StatelessWidget {
  const _PackageInfoBody({
    Key? key,
    required PackageInfo? packageInfo,
    required this.theme,
  })  : _packageInfo = packageInfo,
        super(key: key);

  final PackageInfo? _packageInfo;
  final DebugFriendTheme theme;

  @override
  Widget build(BuildContext context) {
    if (_packageInfo == null) {
      return const SizedBox();
    }
    final pi = _packageInfo!;
    return Column(
      children: [
        KeyValueLine(k: 'App name:', v: pi.appName, theme: theme),
        KeyValueLine(k: 'Vaerion:', v: pi.version, theme: theme),
        KeyValueLine(k: 'Build number:', v: pi.buildNumber, theme: theme),
        KeyValueLine(k: 'Package name:', v: pi.packageName, theme: theme),
      ],
    );
  }
}
