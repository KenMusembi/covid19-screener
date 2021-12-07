import 'package:covidscreener/views/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //we route to the dashboard page right away!
      home: Dashboard(),
    );
  }
}


//TO-DO
/*
add a nice welcome page here
*/