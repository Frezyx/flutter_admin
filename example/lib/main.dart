import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
            title: 'Clear app data',
            onTap: () {},
          ),
          ActionCard(
            icon: const Icon(Icons.dining),
            title: 'Test',
            onTap: () {},
          ),
        ],
        builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Title'),
            ),
          );
        },
      ),
    );
  }
}
