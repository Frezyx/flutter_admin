import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/features/device_data/controller/app_data_controller.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class DeviceDataView extends StatefulWidget {
  const DeviceDataView({
    Key? key,
  }) : super(key: key);

  @override
  State<DeviceDataView> createState() => _DeviceDataViewState();
}

class _DeviceDataViewState extends State<DeviceDataView> {
  final _controller = DeviceDataController();

  @override
  void initState() {
    _controller.loadFilesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: _DeviceDataHeader(
                controller: _controller,
                onDeletePressed: () => _deleteFiles(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverList.separated(
              itemCount: _controller.files.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, i) {
                final file = _controller.files[i];
                return _DeviceDataCard(
                  file: file,
                  onTap: () => _deleteFile(i),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteFiles() => _controller.deleteFiles();
  void _deleteFile(int index) => _controller.deleteFile(index);
}

class _DeviceDataHeader extends StatelessWidget {
  const _DeviceDataHeader({
    Key? key,
    required this.controller,
    required this.onDeletePressed,
  }) : super(key: key);

  final DeviceDataController controller;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deice app data',
                style: options.theme.header,
              ),
              Text(
                'Total files count: ${controller.files.length}',
                style: options.theme.body,
              ),
            ],
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class _DeviceDataCard extends StatelessWidget {
  const _DeviceDataCard({
    Key? key,
    required this.file,
    required this.onTap,
  }) : super(key: key);

  final File file;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BaseCard(
        child: Row(
          children: [
            Expanded(
              child: Text(
                file.path,
                style: options.theme.subtitle,
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
