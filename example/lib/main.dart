import 'package:debug_friend/debug_friend.dart';
import 'package:example/utils/iamge_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
            onTap: () {},
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
          final size = MediaQuery.of(context).size;
          return Scaffold(
            body: SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Pick image for test'),
                  ElevatedButton(
                    onPressed: () {
                      ImageManager.pickAndSave();
                    },
                    child: const Text('Pick and save file'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
