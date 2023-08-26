import 'package:flutter/material.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

class BarButton extends StatelessWidget {
  const BarButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 4),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? options.theme.lightCardColor,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
