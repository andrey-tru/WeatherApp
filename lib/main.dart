import 'package:flutter/material.dart';
import 'package:weather_app/template/HomePage.dart';
import 'package:weather_app/template/Search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        '/search': (context) => Search(),
      },
    );
  }
}


