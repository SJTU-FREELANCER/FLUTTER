import 'package:flutter/material.dart';
import 'package:freelancer/mainpage.dart';

class Createjobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create a job",
          ),
        ),
        body: CreatejobsBody(),
      ),
    );
  }
}

class CreatejobsBody extends StatelessWidget {
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
                    "创建招聘信息",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("this is for creating jobs"),
        ],
      ),
    );
  }
}