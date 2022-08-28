import 'dart:io';

import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppActionsBody extends StatelessWidget {
  const AppActionsBody({
    Key? key,
    // this.cards,
  }) : super(key: key);

  // final List<ActionCard>? cards;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomActionBody(
      cards: [
        // const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Debug actions',
            style: theme.textTheme.headline5,
          ),
        ),
        ActionCard(
          onTap: () => exit(0),
          title: 'Close app',
          icon: const Icon(
            Icons.exit_to_app,
          ),
        ),
        ActionCard(
          onTap: () => debugPaintSizeEnabled = !debugPaintSizeEnabled,
          title: 'Show paint sizes',
          icon: const Icon(
            Icons.square_foot,
          ),
        ),
        ActionCard(
          onTap: () => debugPaintBaselinesEnabled = !debugPaintBaselinesEnabled,
          title: 'Show paint baselines',
          icon: const Icon(
            Icons.text_format,
          ),
        ),
        ActionCard(
          onTap: () =>
              debugPaintLayerBordersEnabled = !debugPaintLayerBordersEnabled,
          title: 'Show paint layer borders',
          icon: const Icon(
            Icons.border_style,
          ),
        ),
        ActionCard(
          onTap: () => debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled,
          title: 'Show repaint rainbow',
          icon: const Icon(
            Icons.palette,
          ),
        ),
        ActionCard(
          onTap: () =>
              debugRepaintTextRainbowEnabled = !debugRepaintTextRainbowEnabled,
          title: 'Show repaint text rainbow',
          icon: const Icon(
            Icons.text_rotate_up,
          ),
        ),
        ActionCard(
          onTap: () => debugDisableClipLayers = !debugDisableClipLayers,
          title: 'Disable clip layers',
          icon: const Icon(
            Icons.circle_outlined,
          ),
        ),
        ActionCard(
          onTap: () => debugDisablePhysicalShapeLayers =
              !debugDisablePhysicalShapeLayers,
          title: 'Disable physical shape layers',
          icon: const Icon(
            Icons.rounded_corner,
          ),
        ),
        ActionCard(
          onTap: () => debugDisableOpacityLayers = !debugDisableOpacityLayers,
          title: 'Disable opacity layers',
          icon: const Icon(
            Icons.opacity,
          ),
        ),
        // ...?cards,
      ],
    );
  }
}
