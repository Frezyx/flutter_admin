import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/utils/simulation_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DebugFriendButton extends StatefulWidget {
  final Widget child;

  DebugFriendButton({
    required this.child,
  });

  @override
  _DebugFriendButtonState createState() => _DebugFriendButtonState();
}

class _DebugFriendButtonState extends State<DebugFriendButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.centerRight;
  final _simulationCalculator = SimulationCalculator();

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: _dragAlignment,
      ),
    );

    SpringSimulation simulation =
        _simulationCalculator.calculateSimulation(pixelsPerSecond, size);
    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (DragUpdateDetails details) {
        _setPosition(details, size);
      },
      onPanEnd: (details) {
        _setSide();
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      onTap: () {
        BottomSheetManager.showDebugMenu(context);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Container(
          decoration: BoxDecoration(
            color: theme.accentColor,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: widget.child,
        ),
      ),
    );
  }

  _setSide() {
    final isLeft = _dragAlignment.x < 0.0;
    if (isLeft) {
      setState(() {
        _dragAlignment = Alignment(
          -0.95,
          _dragAlignment.y,
        );
      });
    } else {
      setState(() {
        _dragAlignment = Alignment(
          0.95,
          _dragAlignment.y,
        );
      });
    }
  }

  _setPosition(DragUpdateDetails details, Size size) {
    setState(
      () {
        _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2),
        );
      },
    );
  }
}
