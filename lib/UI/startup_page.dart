import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartupPage(),
    );
  }
}

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  int _currentPageIndex = 0;
  final List<String> _quotes = [
    'Explore the world and create memories that will last a lifetime.',
    'Every destination has a story to tell. What will yours be?',
    'Adventure awaits. Go find it!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/startup_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Add padding here
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      _quotes[_currentPageIndex],
                      key: ValueKey<String>(_quotes[_currentPageIndex]),
                      style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPageIndex < 2) {
                      setState(() {
                        _currentPageIndex++;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    _currentPageIndex < 2 ? 'Next' : 'Start Exploring',
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
