import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/admin_bar/controller/admin_bar_controller.dart';
import 'package:flutter_admin/src/admin_bar/view/view.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

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
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.builder.call(context);
    return FlutterAdminProvider(
      options: FlutterAdminOptions(
        talker: widget.talker,
        theme: widget.adminTheme,
      ),
      child: Directionality(
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
      ),
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
        if (!_controller.barShowing) {
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

  void _expand() => _controller.showBar();
}

class _FlutterAdminBody extends StatelessWidget {
  const _FlutterAdminBody({
    Key? key,
    required this.controller,
    required this.theme,
    required this.builder,
  }) : super(key: key);

  final FlutterAdminBarController controller;
  final FlutterAdminTheme theme;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final fullHeight =
        mq.size.height - mq.padding.top - mq.padding.bottom - 150;
    final options = FlutterAdminProvider.of(context);
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
                  talker: options.talker,
                  controller: controller,
                  expandedHeigh: fullHeight,
                  onLogsTap: () => _openLogs(context, theme),
                  onErrorsTap: () => _openErrors(context, theme),
                  onHttpTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openLogs(BuildContext context, FlutterAdminTheme theme) async {
    final options = FlutterAdminProvider.of(context);
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
            talker: options.talker,
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
    final options = FlutterAdminProvider.of(context);
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
            talker: options.talker,
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

  void _onVerticalDragUpdate(DragUpdateDetails details, double fullHeight) {
    controller.barHeight -= details.delta.dy;
    if (controller.barHeight >= ((fullHeight / 2) + 100) &&
        details.delta.direction < 0) {
      controller.barHeight = fullHeight;
      return;
    }

    if (controller.barHeight <= ((fullHeight / 2) - 100) &&
        details.delta.direction > 0) {
      controller.barHeight = FlutterAdminBarController.defaultBarHeight;
      return;
    }
  }
}
