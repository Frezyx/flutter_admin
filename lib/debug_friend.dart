library debug_friend;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'src/theme/theme.dart';

class DebugFriend extends StatelessWidget {
  const DebugFriend({
    Key? key,
    this.color,
    required this.icon,
    required this.child,
  }) : super(key: key);

  /// Widget that displayed at main Button
  final Widget icon;

  /// Color of debug button
  final Color? color;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          DraggableCard(
            child: icon,
          ),
        ],
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({
    required this.child,
  });

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;

  Animation<Alignment>? _animation;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: _dragAlignment,
      ),
    );

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
        print('Fuck');
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
