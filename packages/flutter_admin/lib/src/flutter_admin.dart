import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/widgets/buttons/buttons.dart';

class FlutterAdmin extends StatefulWidget {
  const FlutterAdmin({
    Key? key,
    this.enabled = kDebugMode,
    required this.builder,
    this.adminTheme = const FlutterAdminTheme(),
    this.talker,
  }) : super(key: key);

  final bool enabled;
  final FlutterAdminTheme adminTheme;
  final WidgetBuilder builder;
  final Talker? talker;

  @override
  State<FlutterAdmin> createState() => _FlutterAdminState();
}

class _FlutterAdminState extends State<FlutterAdmin> {
  final _controller = FlutterAdminBarController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var _sheetOpened = false;

  @override
  void initState() {
    _talker = widget.talker ?? Talker();
    super.initState();
  }

  late final Talker _talker;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.builder.call(context);
    return Material(
      child: Stack(
        children: [
          _FlutterAdminBody(
            controller: _controller,
            theme: widget.adminTheme,
            builder: widget.builder,
            talker: _talker,
            onLogsTap: () => _openLogs(context, widget.adminTheme),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final hiddenBar =
                  _controller.viewType == FlutterAdminViewType.hiden;
              if (hiddenBar) {
                return FlutterAdminButton(
                  theme: widget.adminTheme,
                  child: IconButton(
                    onPressed: () {
                      _controller.viewType = FlutterAdminViewType.expanded;
                    },
                    icon: Icon(
                      Icons.bug_report,
                      color: widget.adminTheme.iconTheme.color,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_sheetOpened,
              child: Navigator(
                onGenerateInitialRoutes: (navigator, name) {
                  return [
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        key: scaffoldKey,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLogs(BuildContext context, FlutterAdminTheme theme) async {
    setState(() => _sheetOpened = true);
    final controller = scaffoldKey.currentState!.showBottomSheet(
      (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return TalkerView(
            talker: _talker,
            scrollController: scrollController,
            theme: TalkerScreenTheme(
              backgroundColor: theme.backgroundColor,
            ),
          );
        },
      ),
      backgroundColor: theme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
    await controller.closed;
    setState(() => _sheetOpened = false);
  }
}

class _FlutterAdminBody extends StatelessWidget {
  const _FlutterAdminBody({
    Key? key,
    required this.controller,
    required this.theme,
    required this.builder,
    required this.talker,
    required this.onLogsTap,
  }) : super(key: key);

  final FlutterAdminBarController controller;
  final FlutterAdminTheme theme;
  final WidgetBuilder builder;
  final Talker talker;

  final VoidCallback onLogsTap;

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
          padding: EdgeInsets.only(bottom: mq.viewPadding.bottom / 2),
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
                onDoubleTap: () => controller.toggleExpanded(fullHeight),
                onVerticalDragUpdate: (details) {
                  _onVerticalDragUpdate(details, fullHeight);
                },
                child: FlutterAdminBar(
                  adminTheme: theme,
                  talker: talker,
                  controller: controller,
                  expandedHeigh: fullHeight,
                  onLogsTap: onLogsTap,
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
      controller.barHeight = FlutterAdminBarController.defaultBarHeight;
      controller.viewType = FlutterAdminViewType.collapsed;
      return;
    }
  }
}
