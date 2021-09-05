import 'dart:math';

import 'package:debug_friend/debug_friend.dart';
import 'package:example/utils/iamge_manager.dart';
import 'package:example/utils/repository/shared_repository.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = SharedRepository();
  await repository.init();
  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.repository}) : super(key: key);
  final SharedRepository repository;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _brightness = Brightness.light;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _navigatorKey,
      home: DebugFriendView(
        icon: const SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.bug_report,
            color: Colors.white,
            size: 34,
          ),
        ),
        customActions: [
          ActionCard(
            icon: const Icon(Icons.delete),
            title: 'Custom action - Clear storage data',
            onTap: () {
              widget.repository.deleteValues();
            },
          ),
          ActionCard(
            icon: const Icon(Icons.dark_mode),
            title: 'Custom action - Enable dark mode',
            onTap: () {
              if (_brightness == Brightness.light) {
                setState(() => _brightness = Brightness.dark);
              } else {
                setState(() => _brightness = Brightness.light);
              }
            },
          ),
          ActionCard(
            icon: const Icon(Icons.notifications_active),
            title: 'Custom action - show dialog',
            onTap: () {
              showDialog(
                context: _navigatorKey.currentContext!,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    title: Text("Custom action"),
                    content: Text("Show dialog"),
                  );
                },
              );
            },
          ),
        ],
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: _AppActionsBody(
                repository: widget.repository,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppActionsBody extends StatelessWidget {
  const _AppActionsBody({
    Key? key,
    required this.repository,
  }) : super(key: key);

  final SharedRepository repository;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            const Text('Pick image for test'),
            ElevatedButton(
              onPressed: () {
                ImageManager.pickAndSave();
              },
              child: const Text('Pick and save file'),
            ),
            const Text('Shared repository data'),
            ElevatedButton(
              onPressed: () {
                repository.addValue(Random().nextInt(100));
              },
              child: const Text('Add data'),
            ),
            StreamBuilder<List<int>>(
              stream: repository.stream,
              initialData: const [],
              builder:
                  (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Text('No data in shared repository');
                }
                return Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, i) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${snapshot.data![i]}'),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
