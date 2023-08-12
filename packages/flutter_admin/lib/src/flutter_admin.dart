import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/admin_bar/view/view.dart';

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

  @override
  void initState() {
    _talker = widget.talker ?? Talker();
    super.initState();
  }

  late final Talker _talker;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.builder.call(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Navigator(
        onGenerateInitialRoutes: (navigator, name) {
          return [
            MaterialPageRoute(
              builder: (context) => Material(
                child: Stack(
                  children: [
                    _FlutterAdminBody(
                      controller: _controller,
                      theme: widget.adminTheme,
                      builder: widget.builder,
                      talker: _talker,
                      onLogsTap: () => _openLogs(
                        context,
                        widget.adminTheme,
                      ),
                      onErrorsTap: () => _openErrors(
                        context,
                        widget.adminTheme,
                      ),
                    ),
                    _FlutterAdminButton(
                      controller: _controller,
                      adminTheme: widget.adminTheme,
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }

  Future<void> _openLogs(BuildContext context, FlutterAdminTheme theme) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, controller) {
          return TalkerView(
            talker: _talker,
            scrollController: controller,
            appBarTitle: 'App logs',
            appBarLeading: UnconstrainedBox(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            theme: TalkerScreenTheme(backgroundColor: theme.backgroundColor),
          );
        },
      ),
      backgroundColor: theme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  Future<void> _openErrors(
    BuildContext context,
    FlutterAdminTheme theme,
  ) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.backgroundColor,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, controller) {
          return TalkerErrorView(
            talker: _talker,
            scrollController: controller,
            theme: theme,
          );
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}

class _FlutterAdminButton extends StatelessWidget {
  const _FlutterAdminButton({
    Key? key,
    required FlutterAdminBarController controller,
    required this.adminTheme,
  })  : _controller = controller,
        super(key: key);

  final FlutterAdminBarController _controller;
  final FlutterAdminTheme adminTheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final hiddenBar = _controller.viewType == FlutterAdminViewType.hiden;
        if (hiddenBar) {
          return FlutterAdminButton(
            theme: adminTheme,
            child: IconButton(
              onPressed: _expand,
              icon: Icon(Icons.bug_report, color: adminTheme.iconTheme.color),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _expand() {
    _controller.viewType = FlutterAdminViewType.expanded;
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
    required this.onErrorsTap,
  }) : super(key: key);

  final FlutterAdminBarController controller;
  final FlutterAdminTheme theme;
  final WidgetBuilder builder;
  final Talker talker;

  final VoidCallback onLogsTap;
  final VoidCallback onErrorsTap;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final fullHeight =
        mq.size.height - mq.padding.top - mq.padding.bottom - 150;
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
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15),
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
                  onErrorsTap: onErrorsTap,
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
