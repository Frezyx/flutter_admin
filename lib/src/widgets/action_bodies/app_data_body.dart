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
  var _files = <File>[];

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
    final theme = Theme.of(context);
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App data',
                      style: theme.textTheme.headline5,
                    ),
                    Text('Total files count: ${_files.length}'),
                  ],
                ),
                IconButton(
                  onPressed: _deleteFiles,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: _files.length,
              separatorBuilder: (_, __) => const SizedBox(height: 0),
              itemBuilder: (BuildContext ctx, i) {
                final f = _files[i];
                return CommonActionBody(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(child: Text('$f.path')),
                      IconButton(
                        onPressed: () => _deleteFile(f),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _deleteFiles() {
    for (final f in _files) {
      _deleteFile(f);
    }
  }

  void _deleteFile(File f) {
    f.delete();
    _loadFilesList();
  }
}
