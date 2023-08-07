import 'dart:math';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Admin demo'),
      },
      builder: (context, child) {
        return NewWidget(child: child!);
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlutterAdmin(
      adminTheme: FlutterAdminTheme(primaryColor: theme.primaryColor),
      talker: talker,
      builder: (context) => child,
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
    talker.good('Payment completed! Waiting for pizza 🍕');
    super.initState();
  }

  void _incrementCounter() {
    setState(() => _counter++);
    talker.log(
      "Count incremented $_counter",
      logLevel: LogLevel.values[Random().nextInt(LogLevel.values.length - 1)],
    );
    showModalBottomSheet(
        context: context, builder: (context) => const SizedBox());
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
