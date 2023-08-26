import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/device_data/controller/app_data_controller.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class DeviceDataBody extends StatefulWidget {
  const DeviceDataBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DeviceDataBody> createState() => _DeviceDataBodyState();
}

class _DeviceDataBodyState extends State<DeviceDataBody> {
  final _controller = DeviceDataController();

  @override
  void initState() {
    _controller.loadFilesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App data',
                        style: options.theme.headerStyle,
                      ),
                      Text(
                        'Total files count: ${_controller.files.length}',
                        style: options.theme.bodyText,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _deleteFiles,
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 10.0),
                itemCount: _controller.files.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, i) {
                  final f = _controller.files[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BaseCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              f.path,
                              style: options.theme.subtitleText,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _deleteFile(i),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  void _deleteFiles() => _controller.deleteFiles();

  void _deleteFile(int index) => _controller.deleteFile(index);
}
