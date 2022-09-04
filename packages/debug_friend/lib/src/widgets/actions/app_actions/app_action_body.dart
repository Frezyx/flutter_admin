import 'dart:io';

import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppActionsBody extends StatefulWidget {
  const AppActionsBody({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final DebugFriendTheme theme;

  @override
  State<AppActionsBody> createState() => _AppActionsBodyState();
}

class _AppActionsBodyState extends State<AppActionsBody> {
  final _controller = AppActionsController();

  @override
  Widget build(BuildContext context) {
    return CustomActionBody(
      cards: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Debug actions',
            style: widget.theme.headerStyle,
          ),
        ),
        ActionCard(
          onTap: () => exit(0),
          title: 'Close app',
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () => debugPaintSizeEnabled = !debugPaintSizeEnabled,
          title: 'Show paint sizes',
          icon: const Icon(
            Icons.square_foot,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () => debugPaintBaselinesEnabled = !debugPaintBaselinesEnabled,
          title: 'Show paint baselines',
          icon: const Icon(
            Icons.text_format,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () =>
              debugPaintLayerBordersEnabled = !debugPaintLayerBordersEnabled,
          title: 'Show paint layer borders',
          icon: const Icon(
            Icons.border_style,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () => debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled,
          title: 'Show repaint rainbow',
          icon: const Icon(
            Icons.palette,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () =>
              debugRepaintTextRainbowEnabled = !debugRepaintTextRainbowEnabled,
          title: 'Show repaint text rainbow',
          icon: const Icon(
            Icons.text_rotate_up,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () => debugDisableClipLayers = !debugDisableClipLayers,
          title: 'Disable clip layers',
          icon: const Icon(
            Icons.circle_outlined,
            color: Colors.white,
          ),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () => debugDisablePhysicalShapeLayers =
              !debugDisablePhysicalShapeLayers,
          title: 'Disable physical shape layers',
          icon: const Icon(Icons.rounded_corner, color: Colors.white),
          theme: widget.theme,
        ),
        ActionCard(
          onTap: () => debugDisableOpacityLayers = !debugDisableOpacityLayers,
          title: 'Disable opacity layers',
          icon: const Icon(Icons.opacity, color: Colors.white),
          theme: widget.theme,
        ),
      ],
    );
  }
}
