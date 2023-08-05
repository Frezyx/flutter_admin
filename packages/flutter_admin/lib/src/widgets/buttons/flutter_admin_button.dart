import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_admin/src/theme/theme.dart';

class FlutterAdminButton extends StatefulWidget {
  const FlutterAdminButton({
    Key? key,
    required this.child,
    required this.theme,
  }) : super(key: key);

  final Widget child;

  final FlutterAdminTheme theme;

  @override
  State<FlutterAdminButton> createState() => _FlutterAdminButtonState();
}

class _FlutterAdminButtonState extends State<FlutterAdminButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.centerRight;
  final _simulationCalculator = _SimulationCalculator();

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: _dragAlignment,
      ),
    );
    _moveToSide();

    final simulation =
        _simulationCalculator.calculateSimulation(pixelsPerSecond, size);
    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _moveToSide();
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
      onPanDown: _onPanDown,
      onPanUpdate: (DragUpdateDetails details) => _setPosition(details, size),
      onPanEnd: (details) =>
          _runAnimation(details.velocity.pixelsPerSecond, size),
      child: Align(
        alignment: _dragAlignment,
        child: Container(
          decoration: BoxDecoration(
            color: widget.theme.lightCardColor,
            shape: BoxShape.circle,
          ),
          child: widget.child,
        ),
      ),
    );
  }

  void _onPanDown(DragDownDetails details) {
    _controller.stop();
  }

  void _moveToSide() {
    var y = _dragAlignment.y;
    if (y > 1) {
      y = 0.95;
    } else if (y < -1) {
      y = -0.95;
    }
    final isOnLeftSide = _dragAlignment.x < 0.0;
    var x = isOnLeftSide ? -0.95 : 0.95;
    setState(() => _dragAlignment = Alignment(x, y));
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

class _SimulationCalculator {
  SpringSimulation calculateSimulation(Offset pixelsPerSecond, Size size) {
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);
    return simulation;
  }
}
