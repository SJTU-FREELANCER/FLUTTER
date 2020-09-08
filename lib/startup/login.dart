import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';

import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/mainpage.dart';
import 'package:freelancer/startup/register.dart';

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
    //get the validation and the token
    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.responseType = ResponseType.plain;

    Response result;
    result = await dio
        .post("/login", data: {"username": _username, "password": _password});

    if (result.statusCode == 200) {
      Map<String, dynamic> tmp = jsonDecode(result.data);
      String loginmsg = tmp["msg"];

      if (loginmsg.contains("成功")) {
        secToken = tmp["token"];
        userRole = tmp["role"];
        print(secToken);
      } else {
        print("wrong username/password!");
      }
    } else {
      print(result.statusCode);
    }

    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response detailedRes;
    var uri =
        Uri.http(serviceUri, "/getUserbyUsername", {"username": _username});

    detailedRes = await Dio().get("$uri", options: options);

    if (detailedRes.statusCode == 200) {
      Map<String, dynamic> user = json.decode(detailedRes.data);
      userStatus = user["role"];

      if (userStatus != 2) {
        _flag = true;
        print("login success");

        userID = user["user_ID"];
        userName = user["userName"];
        userRname = user["user_Name"];
        userEmail = user["email"];
        userPhone = user["phone"];
        userPassword = user["password"];
      } else {
        print(
            "You are temporarily locked by some reason please contact us to unlock!");
      }
    } else {
      print(detailedRes.statusCode);
    }
  }

  bool _thevalidation() {
    return _flag;
  }

  @override
  void initState() {}
  Widget build(BuildContext context) {
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
