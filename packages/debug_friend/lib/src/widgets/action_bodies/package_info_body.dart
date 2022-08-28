import 'package:debug_friend/src/services/package_info/service.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoBody extends StatefulWidget {
  const PackageInfoBody({Key? key}) : super(key: key);

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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Package info',
            style: theme.textTheme.headline5,
          ),
        ),
        CommonActionBody(
          child: SizedBox(
            width: size.width,
            child: _PackageInfoBody(packageInfo: _packageInfo),
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
  })  : _packageInfo = packageInfo,
        super(key: key);

  final PackageInfo? _packageInfo;

  @override
  Widget build(BuildContext context) {
    if (_packageInfo == null) {
      return const SizedBox();
    }
    final pi = _packageInfo!;
    return Column(
      children: [
        KeyValueLine(k: 'App name:', v: pi.appName),
        KeyValueLine(k: 'Vaerion:', v: pi.version),
        KeyValueLine(k: 'Build number:', v: pi.buildNumber),
        KeyValueLine(k: 'Package name:', v: pi.packageName),
      ],
    );
  }
}
