import 'package:flutter/material.dart';

class CustomActionBody extends StatelessWidget {
  const CustomActionBody({Key? key, this.cards}) : super(key: key);

  final List<Widget>? cards;

  @override
  Widget build(BuildContext context) {
    if (cards == null || cards!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No custom actions'),
      );
    }
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: cards!.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (BuildContext ctx, i) {
          return cards![i];
        },
      ),
    );
  }
}

// GridView.builder(
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 100,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: cards!.length,
//         itemBuilder: (BuildContext ctx, i) {
//           return cards![i];
//         },
//       ),
