import 'package:flutter/material.dart';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/startup/login.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FlRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: RegisterBody(),
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  RegisterBody({Key key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String _username;
  String _password;
  String _email;
  String _phone;
  _sendReinfo() async {
    var apiUrl = "${baseUrl}register?";
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
                    runApp(FlLogin());
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 30,
                  ),
                  child: Text(
                    "注册",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "请输入用户名",
                prefixIcon: Icon(Icons.person),
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
                labelText: "请输入密码",
                prefixIcon: Icon(Icons.lock),
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
                labelText: "请输入手机号码",
                prefixIcon: Icon(Icons.phone),
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
                labelText: "请输入邮箱",
                prefixIcon: Icon(Icons.mail),
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
                  "同意协议并注册",
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                onPressed: () {
                  _sendReinfo();
                  runApp(FlLogin());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "请仔细阅读《用户手册》和《隐私设置》",
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
