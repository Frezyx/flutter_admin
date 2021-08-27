import 'dart:io';

import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppActionsBody extends StatelessWidget {
  const AppActionsBody({
    Key? key,
    this.cards,
  }) : super(key: key);

  final List<ActionCard>? cards;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Device info',
              style: theme.textTheme.headline5,
            ),
          ),
          CustomActionBody(
            cards: [
              ActionCard(
                onTap: () => exit(0),
                title: 'Close app',
                icon: const Icon(
                  Icons.exit_to_app,
                ),
              ),
              ...?cards,
            ],
          ),
        ],
      ),
    );
  }
}
