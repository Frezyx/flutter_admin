import 'package:flutter/material.dart';
import 'package:flutter_admin/flutter_admin.dart';

final talker = TalkerFlutter.init();

void main() {
  runApp(const MyApp());
}

final theme = ThemeData(useMaterial3: true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterAdmin(
      theme: theme,
      adminTheme: FlutterAdminTheme(primaryColor: theme.primaryColor),
      talker: talker,
      builder: (context) => MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        home: const MyHomePage(title: 'Flutter Admin demo'),
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

  void _incrementCounter() {
    setState(() => _counter++);
    talker.good("Count incremented $_counter");
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
