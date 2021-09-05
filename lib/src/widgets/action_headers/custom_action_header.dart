import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomActionHeader extends StatelessWidget {
  const CustomActionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CommonActionHeader(
      icon: Icon(Icons.extension),
    );
  }
}
