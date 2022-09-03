import 'dart:io';

import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppActionsBody extends StatelessWidget {
  const AppActionsBody({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final DebugFriendTheme theme;

  @override
  Widget build(BuildContext context) {
    return CustomActionBody(
      cards: [
        // const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Debug actions',
            style: theme.headerStyle,
          ),
        ),
        ActionCard(
          onTap: () => exit(0),
          title: 'Close app',
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () => debugPaintSizeEnabled = !debugPaintSizeEnabled,
          title: 'Show paint sizes',
          icon: const Icon(
            Icons.square_foot,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () => debugPaintBaselinesEnabled = !debugPaintBaselinesEnabled,
          title: 'Show paint baselines',
          icon: const Icon(
            Icons.text_format,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () =>
              debugPaintLayerBordersEnabled = !debugPaintLayerBordersEnabled,
          title: 'Show paint layer borders',
          icon: const Icon(
            Icons.border_style,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () => debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled,
          title: 'Show repaint rainbow',
          icon: const Icon(
            Icons.palette,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () =>
              debugRepaintTextRainbowEnabled = !debugRepaintTextRainbowEnabled,
          title: 'Show repaint text rainbow',
          icon: const Icon(
            Icons.text_rotate_up,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () => debugDisableClipLayers = !debugDisableClipLayers,
          title: 'Disable clip layers',
          icon: const Icon(
            Icons.circle_outlined,
            color: Colors.white,
          ),
          theme: theme,
        ),
        ActionCard(
          onTap: () => debugDisablePhysicalShapeLayers =
              !debugDisablePhysicalShapeLayers,
          title: 'Disable physical shape layers',
          icon: const Icon(Icons.rounded_corner, color: Colors.white),
          theme: theme,
        ),
        ActionCard(
          onTap: () => debugDisableOpacityLayers = !debugDisableOpacityLayers,
          title: 'Disable opacity layers',
          icon: const Icon(Icons.opacity, color: Colors.white),
          theme: theme,
        ),
      ],
    );
  }
}
