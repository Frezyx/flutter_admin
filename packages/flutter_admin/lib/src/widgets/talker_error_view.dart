import 'package:flutter/material.dart';

import 'package:flutter_admin/flutter_admin.dart';

class TalkerErrorView extends StatelessWidget {
  const TalkerErrorView({
    Key? key,
    required this.talker,
    required this.theme,
    required this.scrollController,
  }) : super(key: key);

  final Talker talker;
  final FlutterAdminTheme theme;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return TalkerErrorsBuilder(
      talker: talker,
      builder: (context, errors) {
        return Column(
          children: [
            AppBar(
              backgroundColor: theme.backgroundColor,
              title: const Text(
                'App errors',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UnconstrainedBox(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return TalkerDataCard(
                          data: errors[i],
                          onTap: () {},
                          expanded: true,
                        );
                      },
                      childCount: errors.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
