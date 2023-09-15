import 'package:flutter/material.dart';
import 'package:flutter_admin/src/features/inspector/controller/inspector_controller.dart';
import 'package:flutter_admin/src/features/inspector/models/inspector_action.dart';
import 'package:flutter_admin/src/features/inspector/widget/inspector_card.dart';

class InspectorView extends StatefulWidget {
  const InspectorView({Key? key}) : super(key: key);

  @override
  State<InspectorView> createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  final _controller = InspectorController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        var actions = [
          InspectorAction(
            onTap: _controller.toggleDebugPaintSizeEnabled,
            title: 'Show paint sizes',
            icon: const Icon(Icons.square_foot, color: Colors.white),
            selected: _controller.debugPaintSizeEnabled,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugPaintBaselinesEnabled,
            title: 'Show paint baselines',
            icon: const Icon(Icons.text_format, color: Colors.white),
            selected: _controller.debugPaintBaselinesEnabled,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugPaintLayerBordersEnabled,
            title: 'Show paint layer borders',
            icon: const Icon(Icons.border_style, color: Colors.white),
            selected: _controller.debugPaintLayerBordersEnabled,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugRepaintRainbowEnabled,
            title: 'Show repaint rainbow',
            icon: const Icon(Icons.palette, color: Colors.white),
            selected: _controller.debugRepaintRainbowEnabled,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugRepaintTextRainbowEnabled,
            title: 'Show repaint text rainbow',
            icon: const Icon(Icons.text_rotate_up, color: Colors.white),
            selected: _controller.debugRepaintTextRainbowEnabled,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugDisableClipLayers,
            title: 'Disable clip layers',
            icon: const Icon(Icons.circle_outlined, color: Colors.white),
            selected: _controller.debugDisableClipLayers,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugDisablePhysicalShapeLayers,
            title: 'Disable physical shape layers',
            icon: const Icon(Icons.rounded_corner, color: Colors.white),
            selected: _controller.debugDisablePhysicalShapeLayers,
          ),
          InspectorAction(
            onTap: _controller.toggleDebugDisableOpacityLayers,
            title: 'Disable opacity layers',
            icon: const Icon(Icons.opacity, color: Colors.white),
            selected: _controller.debugDisableOpacityLayers,
          ),
          InspectorAction(
            onTap: _controller.exitApp,
            title: 'Close app',
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ];
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverList.separated(
              itemCount: actions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final action = actions[index];
                return InspectorCard(action: action);
              },
            ),
          ],
        );
      },
    );
  }
}
