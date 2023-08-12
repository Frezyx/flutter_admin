import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

class TalkerErrorsBuilder extends StatelessWidget {
  const TalkerErrorsBuilder({
    Key? key,
    required this.talker,
    required this.builder,
  }) : super(key: key);

  final Talker talker;
  final Widget Function(BuildContext context, List<TalkerDataInterface> errors)
      builder;

  @override
  Widget build(BuildContext context) {
    return TalkerBuilder(
      talker: talker,
      builder: (context, data) {
        final errors = [
          ...data.whereType<TalkerError>(),
          ...data.where(
            (e) =>
                e.runtimeType == TalkerError ||
                e.logLevel == LogLevel.error ||
                e.logLevel == LogLevel.critical,
          ),
        ];
        return builder.call(context, errors);
      },
    );
  }
}
