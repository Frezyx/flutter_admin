import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';
import 'package:flutter_admin/src/utils/utils.dart';

class NetworkView extends StatelessWidget {
  const NetworkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    final controller = options.networkController;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _NetworkStatsCard(
                        title: 'Sent',
                        bytes: controller.sentBytes,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _NetworkStatsCard(
                        title: 'Received',
                        bytes: controller.receivedBytes,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NetworkStatsCard extends StatelessWidget {
  const _NetworkStatsCard({
    Key? key,
    required this.bytes,
    required this.title,
  }) : super(key: key);

  final num bytes;
  final String title;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ByteFormatter.fmt(bytes),
            style: options.theme.header.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: options.theme.body,
          )
        ],
      ),
    );
  }
}
