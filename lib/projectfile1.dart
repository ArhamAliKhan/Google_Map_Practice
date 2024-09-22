import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakery Location App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ProjectFile2(), // Starting point of the app
    );
  }
}
