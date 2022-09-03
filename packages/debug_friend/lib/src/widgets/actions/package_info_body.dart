import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/services/package_info/service.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoBody extends StatefulWidget {
  const PackageInfoBody({Key? key, required this.theme}) : super(key: key);

  final DebugFriendTheme theme;

  @override
  _PackageInfoBodyState createState() => _PackageInfoBodyState();
}

class _PackageInfoBodyState extends State<PackageInfoBody> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    _loadPackageInfo();
    super.initState();
  }

  Future<void> _loadPackageInfo() async {
    final d = await PackageInfoService.getInfo();
    setState(() => _packageInfo = d);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final t = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Package info',
            style: t.textTheme.headline5?.copyWith(color: Colors.white),
          ),
        ),
        CommonActionBody(
          theme: widget.theme,
          child: SizedBox(
            width: size.width,
            child: _PackageInfoBody(
              packageInfo: _packageInfo,
              theme: widget.theme,
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
