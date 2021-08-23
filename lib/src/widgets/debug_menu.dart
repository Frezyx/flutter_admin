import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

class DebugFriendMenu extends StatefulWidget {
  const DebugFriendMenu({
    Key? key,
    required this.bodies,
    required this.headers,
  }) : super(key: key);

  final List<Widget> bodies;
  final List<Widget> headers;

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
    return SizedBox(
      height: size.height * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            transform: Matrix4.translationValues(0, -20, 0),
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
          Transform(
            transform: Matrix4.translationValues(0, -10, 0),
            child: SizedBox(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.headers
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
          ),
          widget.bodies[_selectedIndex],
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: style ?? theme.textTheme.bodyText1,
      ),
    );
  }
}
