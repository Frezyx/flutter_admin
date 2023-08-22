import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

class BarButton extends StatelessWidget {
  const BarButton({
    Key? key,
    this.onPressed,
    required this.child,
    required this.adminTheme,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final FlutterAdminTheme adminTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 4),
          ),
          maximumSize: const MaterialStatePropertyAll(Size.fromWidth(150)),
          backgroundColor: MaterialStatePropertyAll(adminTheme.lightCardColor),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
