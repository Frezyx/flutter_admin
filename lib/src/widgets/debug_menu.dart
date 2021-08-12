import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class DebugFriendMenu extends StatefulWidget {
  const DebugFriendMenu({
    Key? key,
    required this.items,
    required this.commonItems,
  }) : super(key: key);

  final List<Widget> items;
  final List<Widget> commonItems;

  @override
  _DebugFriendMenuState createState() => _DebugFriendMenuState();
}

class _DebugFriendMenuState extends State<DebugFriendMenu> {
  int _selectedIndex = 0;

  void _closeMenu(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Transform(
      transform: Matrix4.translationValues(0, -20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [Defaults.getShadow(theme)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Title(
                  title: 'Debug Menu',
                  style: theme.textTheme.headline5,
                ),
                IconButton(
                  onPressed: () => _closeMenu(context),
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.commonItems
                    .asMap()
                    .entries
                    .map((e) => GestureDetector(
                          onTap: () => setState(() => _selectedIndex = e.key),
                          child: e.value,
                        ))
                    .toList(),
              ),
            ),
          ),
          SingleChildScrollView(
            child: widget.items[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

// Expanded(
//   child: GridView.builder(
//     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//       maxCrossAxisExtent: 100,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//     ),
//     itemCount: items.length,
//     itemBuilder: (BuildContext ctx, i) {
//       return items[i];
//     },
//   ),
// ),

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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: style ?? theme.textTheme.bodyText1,
      ),
    );
  }
}
