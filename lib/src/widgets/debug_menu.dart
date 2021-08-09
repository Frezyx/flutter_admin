import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class DebugFriendMenu extends StatelessWidget {
  const DebugFriendMenu({
    Key? key,
    required this.items,
    required this.commonItems,
  }) : super(key: key);

  final List<Widget> items;
  final List<Widget> commonItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              boxShadow: [Defaults.getShadow(theme)],
            ),
            child: _Title(
              title: 'Debug Menu',
              style: theme.textTheme.headline5,
            ),
          ),
          const SizedBox(height: 10),
          // const _Title(title: 'Common actions'),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: commonItems,
              ),
            ),
          ),
          // const _Title(title: 'Custom actions'),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext ctx, i) {
                return items[i];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.title,
    this.style,
  }) : super(key: key);

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: style ?? theme.textTheme.bodyText1,
          ),
          // const Divider(height: 6),
        ],
      ),
    );
  }
}
