import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
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
  static const _defaultBarHeight = 60.0;
  var _barHeight = _defaultBarHeight;

  @override
  Widget build(BuildContext context) {
    return MediaQueryIjector(
      child: Builder(
        builder: (context) {
          final mq = MediaQuery.of(context);
          final fullHeight =
              mq.size.height - mq.padding.top - mq.padding.bottom - 150;
          final appBorderRadius = fullHeight / _barHeight * 1.5;
          return Container(
            decoration: BoxDecoration(color: widget.theme.backgroundColor),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(appBorderRadius),
                    child: widget.builder.call(context),
                  ),
                ),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() => _barHeight -= details.delta.dy);
                    if (_barHeight >= ((fullHeight / 2) + 100) &&
                        details.delta.direction < 0) {
                      setState(() => _barHeight = fullHeight);
                      print('asdasdasdasdasdasdasdasd');
                      return;
                    }

                    if (_barHeight <= ((fullHeight / 2) - 100) &&
                        details.delta.direction > 0) {
                      setState(() => _barHeight = _defaultBarHeight);
                      print('UUUUUUUUUUU');
                      return;
                    }
                  },
                  child: FlutterAdminBar(
                    theme: widget.theme,
                    height: _barHeight,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
