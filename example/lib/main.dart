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
      home: DebugFriend(
        icon: SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            Icons.bug_report,
            size: 34,
          ),
        ),
        child: Scaffold(
          body: Center(
            child: Text('Title'),
          ),
        ),
      ),
    );
  }
}
