// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = Talker(
  settings: TalkerSettings(
    useConsoleLogs: kDebugMode,
    useHistory: kDebugMode,
  ),
);
