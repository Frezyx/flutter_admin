import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';
import 'package:flutter_admin/src/features/inspector/models/inspector_action.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';

/// Creates a custom button for any test action in your application
///
/// {@tool snippet}
///
/// This sample shows how to define an action card.
///
/// ```dart
/// InspectorCard(
///   icon: const Icon(Icons.dark_mode),
///   title: 'Enable dark mode',
///   onTap: () {
///     // Your custom action to toggle theme mode
///   },
/// ),
/// ```
/// {@end-tool}
class InspectorCard extends StatelessWidget {
  const InspectorCard({
    Key? key,
    required this.action,
  }) : super(key: key);

  final InspectorAction action;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: action.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BaseCard(
          backgroundColor: action.selected ? theme.primaryColor : null,
          child: Row(
            children: [
              action.icon,
              if (action.title != null) const SizedBox(width: 10),
              if (action.title != null)
                Text(action.title!, style: options.theme.body),
            ],
          ),
        ),
      ),
    );
  }
}
