import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(maxHistoryItems: 10000),
);
final dio = Dio();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Admin demo'),
      },
      builder: (context, child) => FlutterAdmin(
        adminTheme: const FlutterAdminTheme(),
        talker: talker,
        dio: dio,
        builder: (context) => child!,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    talker.warning('The pizza is over 😥');
    talker.debug('Thinking about order new one 🤔');
    talker.error('The restaurant is closed ❌');
    talker.info('Ordering from other restaurant...');
    talker.info('Payment started...');
    super.initState();
  }

  void _makeTestRequests() {
    dio.get('https://jsonplaceholder.typicode.com/todos/');
    dio.get('https://jsonplaceholder.typicode.com/todos/1');
    dio.get('https://jsonplaceholder.typicode.com/todos/2');
    dio.post(
      'https://jsonplaceholder.typicode.com/todos/',
      data: {
        "userId": 10,
        "id": 199,
        "title": "numquam repellendus a magnam",
        "completed": true
      },
    );
  }

  void _incrementCounter() {
    setState(() => _counter++);
    _makeTestRequests();
    talker.log(
      "Count incremented $_counter",
      logLevel: LogLevel.values[Random().nextInt(LogLevel.values.length - 1)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
