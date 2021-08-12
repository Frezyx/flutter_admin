import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class CustomActionBody extends StatelessWidget {
  const CustomActionBody({Key? key, this.cards}) : super(key: key);

  final List<ActionCard>? cards;

  @override
  Widget build(BuildContext context) {
    return const CommonActionBody(
      child: Center(child: Text('SSS')),
    );
  }
}
