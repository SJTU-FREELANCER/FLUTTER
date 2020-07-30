import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/mainpage.dart';
import 'package:freelancer/sharedinfo/config.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

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
  String taruser;
  _setUser() async {
    var apiUrl = "${baseUrl}change_state";
    var result = await http.post(apiUrl, body: {
      "userid": taruser,
    });
    if (result.statusCode == 200) {
      print("success set role");
    } else {
      print(result.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  "管理员工具",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 485,
          width: 300,
          child: ListView(children: [
            RaisedButton(
              child: Text("设置用户权限"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('请选择要解禁/禁用的用户ID'),
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              labelText: "uerID",
                              prefixIcon: Icon(Icons.category),
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
                              taruser = value;
                            },
                          ),
                          RaisedButton(
                            child: Text("确定"),
                            onPressed: () {
                              _setUser();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              },
            ),
          ]),
        ),
      ],
    );
  }
}
