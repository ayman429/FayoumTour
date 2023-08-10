import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Current Time'),
        ),
        body: Center(
          child: Text(
            'Current Time: $formattedTime',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
