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
    return CustomActionBody(
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
    );
  }
}
