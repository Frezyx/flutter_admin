import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/utils/simulation_calculator.dart';
import 'package:flutter/material.dart';

class DebugFriendButton extends StatefulWidget {
  const DebugFriendButton({
    required this.child,
    required this.onTap,
    required this.theme,
  });
  final Widget child;
  final Function() onTap;
  final DebugFriendTheme theme;

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
    _setSide();

    final simulation =
        _simulationCalculator.calculateSimulation(pixelsPerSecond, size);
    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _setSide();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (DragUpdateDetails details) {
        _setPosition(details, size);
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      onTap: widget.onTap,
      child: Align(
        alignment: _dragAlignment,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.theme.primaryColor,
            shape: BoxShape.circle,
          ),
          child: widget.child,
        ),
      ),
    );
  }

  void _setSide() {
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

  void _setPosition(DragUpdateDetails details, Size size) {
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
