import 'package:flutter/material.dart';
import 'package:freelancer/mainpage.dart';

class Flmanage extends StatefulWidget {
  Flmanage({Key key}) : super(key: key);

  @override
  _FlmanageState createState() => _FlmanageState();
}

class _FlmanageState extends State<Flmanage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Managebody(),
      ),
    );
  }
}

class Managebody extends StatefulWidget {
  Managebody({Key key}) : super(key: key);

  @override
  _ManagebodyState createState() => _ManagebodyState();
}

class _ManagebodyState extends State<Managebody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                runApp(FlMainpage());
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                bottom: 30,
              ),
              child: Text(
                "管理员工具",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
