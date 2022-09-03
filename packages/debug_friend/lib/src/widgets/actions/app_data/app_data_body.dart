import 'package:debug_friend/debug_friend.dart';
import 'package:debug_friend/src/widgets/actions/app_data/app_data_controller.dart';
import 'package:debug_friend/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppDataBody extends StatefulWidget {
  const AppDataBody({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final DebugFriendTheme theme;

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
                          style: widget.theme.headerStyle,
                        ),
                        Text(
                          'Total files count: ${_controller.files.length}',
                          style: widget.theme.bodyText,
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
                      theme: widget.theme,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              f.path,
                              style: widget.theme.subtitleText,
                            ),
                          ),
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
      },
    );
  }

  void _deleteFiles() => _controller.deleteFiles();

  void _deleteFile(int index) => _controller.deleteFile(index);
}
