import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/utils/utils.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Wraps your application in the debug friend zone
///
/// {@tool snippet}
///
/// This sample shows how to define an app with a plugin.
///
/// ```dart
///DebugFriendView(
///  builder: (context) {
///    return const Scaffold(
///      body: Text('Your app home widget'),
///    );
///  },
/// ),
/// ```
/// {@end-tool}
class DebugFriendView extends StatefulWidget {
  DebugFriendView({
    Key? key,
    this.icon = const Icon(Icons.bug_report),
    required this.builder,
    this.enabled = kDebugMode,
    // this.customActions,
    this.theme,
  })  : _bottomSheetManager = BottomSheetManager(),
        super(key: key);

  /// Widget that displayed at DebugFriend action header
  final Widget icon;

  /// Should return your application widget for which DebugFriend is applied
  final WidgetBuilder builder;

  /// When this field is [true] - debug friend is running in your app
  /// in other case - [DebugFriendButton] going sleep
  /// By default this field get value from const [kDebugMode]
  final bool enabled;

  // /// Custom actions menu items
  // /// They are shown on the 4th page of the menu
  // final List<ActionCard>? customActions;

  final DebugFriendTheme? theme;

  final BottomSheetManager _bottomSheetManager;

  @override
  State<DebugFriendView> createState() => _DebugFriendViewState();
}

class _DebugFriendViewState extends State<DebugFriendView> {
  @override
  void initState() {
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _insertOverlay(context),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context);
  }

  void _insertOverlay(BuildContext context) {
    final theme = widget.theme ?? DebugFriendTheme.fromFlutterTheme(context);
    return Overlay.of(context)!.insert(
      OverlayEntry(
        builder: (context) {
          return DebugFriendButton(
            theme: theme,
            onTap: () => _onButtonTap(context, theme),
            child: widget.icon,
          );
        },
      ),
    );
  }

  void _onButtonTap(BuildContext context, DebugFriendTheme theme) {
    widget._bottomSheetManager.showBottomSheet(
      context,
      theme: theme,
      builder: (ctx) {
        return DebugFriendMenu(
          theme: theme,
          headers: const [
            Icons.app_settings_alt,
            Icons.folder_open,
            Icons.touch_app,
            // Icons.extension,
          ],
          bodies: [
            AppInfoBody(theme: theme),
            AppDataBody(theme: theme),
            AppActionsBody(theme: theme),
            // CustomActionBody(cards: widget.customActions),
          ],
        );
      },
    );
  }
}
