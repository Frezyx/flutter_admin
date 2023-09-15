import 'package:flutter/material.dart';
import 'package:flutter_admin/src/admin_bar/view/widgets/widgets.dart';
import 'package:flutter_admin/src/flutter_admin_provider.dart';
import 'package:group_button/group_button.dart';

class AdminBarPageSelector extends StatelessWidget {
  const AdminBarPageSelector({
    Key? key,
    required this.onSelected,
    required this.controller,
    required this.actions,
  }) : super(key: key);

  final List<AdminBarAction> actions;
  final GroupButtonController controller;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = FlutterAdminProvider.of(context);
    return SizedBox(
      height: 44,
      child: ListView(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        children: [
          GroupButton<AdminBarAction>(
            controller: controller,
            isRadio: true,
            buttons: actions,
            onSelected: (_, index, __) => onSelected(index),
            buttonBuilder: (selected, e, context) {
              return BarButton(
                backgroundColor:
                    selected ? Theme.of(context).primaryColor : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      e.icon,
                      color: options.theme.iconTheme.color,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      e.title,
                      style: options.theme.body.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AdminBarAction {
  const AdminBarAction({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}
