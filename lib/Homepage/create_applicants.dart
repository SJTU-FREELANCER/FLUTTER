import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/mainpage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Createapplicants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: CreateapplicantsBody(),
      ),
    );
  }
}

class CreateapplicantsBody extends StatefulWidget {
  CreateapplicantsBody({Key key}) : super(key: key);

  @override
  _CreateapplicantsBodyState createState() => _CreateapplicantsBodyState();
}

class _CreateapplicantsBodyState extends State<CreateapplicantsBody> {
  String _username;
  String _password;
  String _email;
  String _phone;
  _sendReinfo() async {
    var apiUrl = "http://10.0.2.2:8080/register?";
    var result = await http.post(apiUrl, body: {
      "username": "$_username",
      "password": "$_password",
      "phone": "$_phone",
      "email": "$_email"
    });
    if (result.statusCode == 200) {
      print(json.decode(result.body) is Map);
    } else {
      print(result.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      //上下左右各添加16像素补白
      padding: EdgeInsets.only(top: 50),
      child: Container(
        child: ListView(
          children: <Widget>[
            Row(
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
                    "求职申请",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "请输入学历",
                prefixIcon: Icon(Icons.school),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                _username = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "请输入经验",
                prefixIcon: Icon(Icons.settings_applications),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "请输入真实姓名",
                prefixIcon: Icon(Icons.person_pin),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                _phone = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "请输入生日",
                prefixIcon: Icon(Icons.present_to_all),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: RaisedButton.icon(
                icon: Icon(Icons.done_all),
                label: Text(
                  "同意工作协议并发布",
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                onPressed: () {
                  _sendReinfo();
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 150, top: 50),
              child: Text(
                "请仔细阅读《工作协议》和《招聘协议》",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
