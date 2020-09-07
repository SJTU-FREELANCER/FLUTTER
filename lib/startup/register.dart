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
  String _msg;

  bool success = false;
  _sendReinfo() async {
    var apiUrl = "${serviceUrl}register?";
    var result = await http.post(apiUrl, body: {
      "username": "$_username",
      "password": "$_password",
      "phone": "$_phone",
      "email": "$_email"
    });
    if (result.statusCode == 200) {
      Map<String, dynamic> tmp = json.decode(result.body);
      print(tmp["status"]);
      print(tmp["message"]);
      if (tmp["status"] == 0) {
        success = true;
        _msg = tmp["message"];
        print(tmp["message"]);
      }
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

                  showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('注册结果'),
                        content: new SingleChildScrollView(
                          child: new ListBody(
                            children: <Widget>[
                              new Text('您已经完成注册，请返回登陆！'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('返回登陆界面'),
                            onPressed: () {
                              runApp(FlLogin());
                            },
                          ),
                        ],
                      );
                    },
                  ).then((val) {
                    print(val);
                  });
                },
              ),
            ),
            // new MaterialButton(
            //   color: Colors.blue,
            //   child: new Text('点我'),
            //   onPressed: () {
            //     showDialog<Null>(
            //       context: context,
            //       barrierDismissible: false,
            //       builder: (BuildContext context) {
            //         return new AlertDialog(
            //           title: new Text('标题'),
            //           content: new SingleChildScrollView(
            //             child: new ListBody(
            //               children: <Widget>[
            //                 new Text('内容 1'),
            //                 new Text('内容 2'),
            //               ],
            //             ),
            //           ),
            //           actions: <Widget>[
            //             new FlatButton(
            //               child: new Text('确定'),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //           ],
            //         );
            //       },
            //     ).then((val) {
            //       print(val);
            //     });
            //   },
            // ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 130),
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
