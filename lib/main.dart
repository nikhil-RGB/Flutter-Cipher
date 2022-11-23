import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root Widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipher App',
      theme: ThemeData(
        // Application theme
        hintColor: Colors.cyan,
        primarySwatch: Colors.cyan,
      ),
      home: home(),
    );
  }
}
