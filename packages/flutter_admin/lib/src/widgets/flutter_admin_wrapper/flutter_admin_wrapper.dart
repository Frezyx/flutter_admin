import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/widgets/helpers/helpers.dart';

class FlutterAdminWrapper extends StatelessWidget {
  const FlutterAdminWrapper({
    Key? key,
    required this.builder,
    this.theme = const FlutterAdminTheme(),
  }) : super(key: key);

  final FlutterAdminTheme theme;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MediaQueryIjector(
      child: Container(
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: builder.call(context),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(color: theme.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
