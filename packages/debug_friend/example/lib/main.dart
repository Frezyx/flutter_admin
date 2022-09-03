import 'package:debug_friend/debug_friend.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DebugFriend',
      theme: ThemeData(primaryColor: Colors.black),
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
        theme: const DebugFriendTheme(),
        // customActions: [
        //   ActionCard(
        //     icon: const Icon(Icons.print_rounded),
        //     title: 'Print to console',
        //     onTap: () => debugPrint('Print to console'),
        //   ),
        // ],
        builder: (context) {
          return const SafeArea(
            child: Scaffold(
              body: Center(
                child: Text('DebugFriend'),
              ),
            ),
          );
        },
      ),
    );
  }
}
