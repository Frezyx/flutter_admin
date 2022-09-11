import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/controller/flutter_admin_controller.dart';
import 'package:flutter_admin/src/widgets/buttons/buttons.dart';
import 'package:flutter_admin/src/widgets/helpers/helpers.dart';

class FlutterAdminWrapper extends StatefulWidget {
  const FlutterAdminWrapper({
    Key? key,
    required this.builder,
    this.theme = const FlutterAdminTheme(),
  }) : super(key: key);

  final FlutterAdminTheme theme;
  final WidgetBuilder builder;

  @override
  State<FlutterAdminWrapper> createState() => _FlutterAdminWrapperState();
}

class _FlutterAdminWrapperState extends State<FlutterAdminWrapper> {
  final _controller = FlutterAdminController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MediaQueryIjector(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return Stack(
                children: [
                  _FlutterAdminBody(
                    controller: _controller,
                    theme: widget.theme,
                    builder: widget.builder,
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final hiddenBar =
                          _controller.viewType == FlutterAdminViewType.hiden;

                      if (hiddenBar) {
                        return FlutterAdminButton(
                          theme: widget.theme,
                          onTap: () {},
                          child: IconButton(
                            onPressed: () {
                              _controller.viewType =
                                  FlutterAdminViewType.expanded;
                            },
                            icon: Icon(
                              Icons.bug_report,
                              color: widget.theme.iconTheme.color,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FlutterAdminBody extends StatelessWidget {
  const _FlutterAdminBody({
    Key? key,
    required this.controller,
    required this.theme,
    required this.builder,
  }) : super(key: key);

  final FlutterAdminController controller;
  final FlutterAdminTheme theme;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final fullHeight =
        mq.size.height - mq.padding.top - mq.padding.bottom - 150;
    var appBorderRadius = fullHeight / controller.barHeight * 1.5;
    if (appBorderRadius > 15) {
      appBorderRadius = 15;
    }
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(color: theme.backgroundColor),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(appBorderRadius),
                  ),
                  child: builder.call(context),
                ),
              ),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  _onVerticalDragUpdate(details, fullHeight);
                },
                child: FlutterAdminBar(
                  theme: theme,
                  height: controller.barHeight,
                  controller: controller,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details, double fullHeight) {
    controller.barHeight -= details.delta.dy;
    if (controller.barHeight >= ((fullHeight / 2) + 100) &&
        details.delta.direction < 0) {
      controller.barHeight = fullHeight;
      controller.viewType = FlutterAdminViewType.expanded;
      return;
    }

    if (controller.barHeight <= ((fullHeight / 2) - 100) &&
        details.delta.direction > 0) {
      controller.barHeight = FlutterAdminController.defaultBarHeight;
      controller.viewType = FlutterAdminViewType.collapsed;
      return;
    }
  }
}
