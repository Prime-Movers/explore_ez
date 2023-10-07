import 'package:flutter/material.dart';
import 'startup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Page Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartupPage(), // Start with StartupPage instead of LoginPage
    );
  }
}
