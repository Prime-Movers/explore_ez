import 'package:flutter/material.dart';

void main() {
  runApp(TouristApp());
}

class TouristApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourist App'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Attractions'),
            onTap: () {
              // Navigate to attractions page
            },
          ),
          ListTile(
            leading: Icon(Icons.hotel),
            title: Text('Hotels'),
            onTap: () {
              // Navigate to hotels page
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Restaurants'),
            onTap: () {
              // Navigate to restaurants page
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Maps'),
            onTap: () {
              // Navigate to maps page
            },
          ),
        ],
      ),
    );
  }
}
