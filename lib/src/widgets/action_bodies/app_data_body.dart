import 'dart:io';

import 'package:debug_friend/src/services/file/src/src.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppDataBody extends StatefulWidget {
  const AppDataBody({
    Key? key,
  }) : super(key: key);

  @override
  _AppDataBodyState createState() => _AppDataBodyState();
}

class _AppDataBodyState extends State<AppDataBody> {
  late List<File> _files;

  @override
  void initState() {
    _loadFilesList();
    super.initState();
  }

  Future<void> _loadFilesList() async {
    final files = await FileService.instance.getFiles();
    setState(() => _files = files);
  }

  @override
  Widget build(BuildContext context) {
    if (_files.isEmpty) {
      return const SizedBox();
    }
    return CommonActionBody(
      child: Column(
        children: _files
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$e.path'),
                ))
            .toList(),
      ),
    );
  }
}
