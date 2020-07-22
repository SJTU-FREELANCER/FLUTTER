import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:freelancer/startup/login.dart';

void main() {
  runApp(FlLogin());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CN'),
          const Locale('en', 'US'),
        ],
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "that",
            ),
          ),
        ));
  }
}
