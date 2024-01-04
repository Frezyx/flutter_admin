import 'package:dio/dio.dart';
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
    this.dio,
  }) : super(key: key);

  final bool enabled;
  final FlutterAdminTheme adminTheme;
  final WidgetBuilder builder;
  final Talker? talker;
  final Dio? dio;

  @override
  State<FlutterAdmin> createState() => _FlutterAdminState();
}

class _FlutterAdminState extends State<FlutterAdmin> {
  final _controller = FlutterAdminBarController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late final FlutterAdminOptions options;

  @override
  void initState() {
    options = FlutterAdminOptions(
      talker: widget.talker,
      theme: widget.adminTheme,
      dio: widget.dio,
    )..init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.builder.call(context);
    return FlutterAdminProvider(
      options: options,
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
                        builder: widget.builder,
                      ),
                      _FlutterAdminButton(controller: _controller),
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
  })  : _controller = controller,
        super(key: key);

  final FlutterAdminBarController _controller;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        if (!_controller.barShowing) {
          return FlutterAdminButton(
            child: IconButton(
              onPressed: _expand,
              icon: Icon(
                Icons.bug_report,
                color: options.theme.iconTheme.color,
              ),
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
    required this.builder,
  }) : super(key: key);

  final FlutterAdminBarController controller;
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
          padding: controller.barShowing
              ? EdgeInsets.only(bottom: mq.viewPadding.bottom / 2)
              : EdgeInsets.zero,
          decoration: BoxDecoration(color: options.theme.backgroundColor),
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
                  controller: controller,
                  expandedHeigh: fullHeight,
                  onLogsTap: () => _openLogs(context),
                  onErrorsTap: () => _openErrors(context),
                  onHttpTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openLogs(BuildContext context) async {
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
                icon: const Icon(Icons.close_rounded, color: Colors.white),
              ),
            ),
            theme: TalkerScreenTheme(
              cardColor: options.theme.cardColor,
              backgroundColor: options.theme.backgroundColor,
            ),
          );
        },
      ),
      backgroundColor: options.theme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  Future<void> _openErrors(
    BuildContext context,
  ) async {
    final options = FlutterAdminProvider.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: options.theme.backgroundColor,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, controller) {
          return TalkerErrorView(
            talker: options.talker,
            theme: options.theme,
            scrollController: controller,
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
    // controller.barHeight -= details.delta.dy;

    /// Expand
    //
    // Last condition
    // controller.barHeight >= ((fullHeight / 2) + 100) &&
    //    details.delta.direction < 0
    if (details.globalPosition.dy >= 50 && details.delta.direction < 0) {
      controller.barHeight = fullHeight;
      return;
    }

    /// Collapse
    //
    // Last condition
    // controller.barHeight <= ((fullHeight / 2) - 100) &&
    //    details.delta.direction > 0
    if (details.globalPosition.dy <= fullHeight &&
        details.delta.direction > 0) {
      controller.barHeight = FlutterAdminBarController.defaultBarHeight;
      return;
    }
  }
}
