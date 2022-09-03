import 'package:debug_friend/src/widgets/actions/app_data/app_data_controller.dart';
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
  final _controller = AppDataController();
  // var _files = <File>[];

  @override
  void initState() {
    // _loadFilesList();
    _controller.loadFilesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
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
                          Text(
                            'Total files count: ${_controller.files.length}',
                          ),
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
                    itemCount: _controller.files.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 0),
                    itemBuilder: (BuildContext ctx, i) {
                      final f = _controller.files[i];
                      return CommonActionBody(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text('$f.path')),
                            IconButton(
                              onPressed: () => _deleteFile(i),
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
        });
  }

  void _deleteFiles() => _controller.deleteFiles();

  void _deleteFile(int index) => _controller.deleteFile(index);
}
