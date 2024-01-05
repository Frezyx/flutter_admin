import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';
import 'package:flutter_admin/src/utils/utils.dart';

class NetworkView extends StatelessWidget {
  const NetworkView({
    Key? key,
  }) : super(key: key);

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
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        const HttpLogsSliverList(),
      ],
    );
  }
}

class HttpLogsSliverList extends StatelessWidget {
  const HttpLogsSliverList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    final controller = options.networkController;
    final responses = controller.responses.entries.toList();

    return SliverList.separated(
      itemBuilder: (context, index) {
        final requestResponse = responses[index];
        return HttpResponseCard(response: requestResponse);
      },
      itemCount: responses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}

class HttpResponseCard extends StatelessWidget {
  const HttpResponseCard({
    Key? key,
    required this.response,
  }) : super(key: key);

  final MapEntry<RequestOptions, Response> response;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BaseCard(
        child: Row(
          children: [
            Expanded(
              child: Text(
                response.key.uri.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              child: Text(
                response.value.statusCode?.toString() ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
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
