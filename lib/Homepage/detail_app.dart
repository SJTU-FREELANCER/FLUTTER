import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/mainpage.dart';

class Appdetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Applicants detail",
          ),
        ),
        body: AppdetailBody(),
      ),
    );
  }
}

class AppdetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Padding(
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
                    "求职标题",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("this is for 求职者细节"),
        ],
      ),
    );
  }
}
