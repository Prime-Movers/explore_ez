import 'dart:convert';

import 'package:app1/function.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  var data;
  String output = 'Initial Output';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gemini_python')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                },
              ),
              TextButton(
                  onPressed: () async {
                    data = await fetchdata(url);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output = decoded['output'];
                    });
                  },
                  child: Text('Generate Plan', style: TextStyle(fontSize: 20))),
              Text(
                output,
                style: TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 21, 225, 28)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
