import 'package:debug_friend/debug_friend.dart';
import 'package:example/utils/iamge_manager.dart';
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
          // ActionCard(
          //   icon: const Icon(Icons.delete),
          //   title: 'Clear app data',
          //   onTap: () {},
          // ),
          // ActionCard(
          //   icon: const Icon(Icons.dining),
          //   title: 'Test',
          //   onTap: () {},
          // ),
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
