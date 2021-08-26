import 'package:debug_friend/src/widgets/action_headers/action_headers.dart';
import 'package:flutter/material.dart';

class AppDataHeader extends StatelessWidget {
  const AppDataHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CommonActionHeader(
      icon: Icon(Icons.folder_open),
    );
  }
}
