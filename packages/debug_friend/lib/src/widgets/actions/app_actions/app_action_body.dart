import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
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
              onTap: _controller.exitApp,
              title: 'Close app',
              icon: const Icon(Icons.exit_to_app, color: Colors.white),
              theme: widget.theme,
            ),
            ActionCard(
              onTap: _controller.toggleDebugPaintSizeEnabled,
              title: 'Show paint sizes',
              icon: const Icon(Icons.square_foot, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugPaintSizeEnabled,
            ),
            ActionCard(
              onTap: _controller.toggleDebugPaintBaselinesEnabled,
              title: 'Show paint baselines',
              icon: const Icon(Icons.text_format, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugPaintBaselinesEnabled,
            ),
            ActionCard(
              onTap: _controller.toggleDebugPaintLayerBordersEnabled,
              title: 'Show paint layer borders',
              icon: const Icon(Icons.border_style, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugPaintLayerBordersEnabled,
            ),
            ActionCard(
              onTap: _controller.toggleDebugRepaintRainbowEnabled,
              title: 'Show repaint rainbow',
              icon: const Icon(Icons.palette, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugRepaintRainbowEnabled,
            ),
            ActionCard(
              onTap: _controller.toggleDebugRepaintTextRainbowEnabled,
              title: 'Show repaint text rainbow',
              icon: const Icon(Icons.text_rotate_up, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugRepaintTextRainbowEnabled,
            ),
            ActionCard(
              onTap: _controller.toggleDebugDisableClipLayers,
              title: 'Disable clip layers',
              icon: const Icon(Icons.circle_outlined, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugDisableClipLayers,
            ),
            ActionCard(
              onTap: _controller.toggleDebugDisablePhysicalShapeLayers,
              title: 'Disable physical shape layers',
              icon: const Icon(Icons.rounded_corner, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugDisablePhysicalShapeLayers,
            ),
            ActionCard(
              onTap: _controller.toggleDebugDisableOpacityLayers,
              title: 'Disable opacity layers',
              icon: const Icon(Icons.opacity, color: Colors.white),
              theme: widget.theme,
              selected: _controller.debugDisableOpacityLayers,
            ),
          ],
        );
      },
    );
  }
}
