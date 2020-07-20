import 'dart:convert';
import 'package:freelancer/config.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:freelancer/mainpage.dart';
import 'package:freelancer/register.dart';

int userID;
String username;
String realname;

int personstatus;

void main() {
  runApp(FlLogin());
}

class FlLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String _username;
  String _password;
  bool _flag = false;
  _getValidation() async {
    var apiUrl = "${baseUrl}login?";
    var result = await http.post(apiUrl,
        body: {"username": "$_username", "password": "$_password"});
    if (result.statusCode == 200) {
      print(json.decode(result.body) is Map);
      Map tmp = json.decode(result.body);
      print(tmp["status"]);
      personstatus = tmp["status"];
      if (tmp["status"] == 2 || tmp["status"] == 1) {
        print("login success");
        _flag = true;
        userID = tmp["user"]["user_ID"];
        username = tmp["user"]["userName"];
        realname = tmp["user"]["user_Name"];
        print("$userID");
        print("$username");
        print("$realname");
      }
    } else {
      print(result.statusCode);
    }
  }

  bool _thevalidation() {
    return _flag;
  }

  @override
  void initState() {}
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
        ),
        Center(
          child: ClipOval(
            child: Container(
              child: Image.asset(
                "images/ld.jpg",
                fit: BoxFit.fill,
              ),
              width: 200,
              height: 200,
            ),
          ),
        ),
        Center(
          child: Text(
            "FREELANCER",
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
        Text(
          "已有账号登陆",
        ),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: "用户名",
            hintText: "您的用户名",
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: (value) {
            setState(() {
              _username = value;
              username = _username;
            });
          },
        ),
        TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            }),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 110),
              child: RaisedButton(
                child: Text("登录"),
                onPressed: () {
                  _getValidation();
                  print(_flag);
                  //_postdata;
                  if (_thevalidation()) {
                    runApp(FlMainpage());
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: RaisedButton(
                child: Text("注册"),
                onPressed: () {
                  runApp(FlRegister());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
