
import 'package:flutter/material.dart';
import './UI/startup_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartupPage(),
      // Start with StartupPage instead of LoginPage
    );
  }
}
