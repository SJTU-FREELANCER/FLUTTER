import 'package:flutter/material.dart';
import 'package:freelancer/login.dart';
import 'package:freelancer/register.dart';

void main() {
  runApp(FlLogin());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(
          "that",
        ),
      ),
    ));
  }
}