import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Creates a custom button for any test action in your application
///
/// {@tool snippet}
///
/// This sample shows how to define an action card.
///
/// ```dart
/// ActionCard(
///   icon: const Icon(Icons.dark_mode),
///   title: 'Enable dark mode',
///   onTap: () {
///     // Your custom action to toggle theme mode
///   },
/// ),
/// ```
/// {@end-tool}
class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.onTap,
    required this.icon,
    this.title,
    required this.theme,
  }) : super(key: key);

  /// Icon of your custom action card
  final Widget icon;

  /// Title of your custom action card
  final String? title;

  /// Your custom method for testing in this action card
  final Function() onTap;

  final DebugFriendTheme theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CommonActionHeader(
            icon: icon,
            theme: theme,
          ),
          if (title != null) const SizedBox(width: 10),
          if (title != null) Text(title!),
        ],
      ),
    );
  }
}
