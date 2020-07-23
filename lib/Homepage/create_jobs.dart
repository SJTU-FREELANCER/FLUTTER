import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/mainpage.dart';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Createjobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Createjobshome(),
      ),
    );
  }
}

class Createjobshome extends StatefulWidget {
  Createjobshome({Key key}) : super(key: key);

  @override
  _CreatejobshomeState createState() => _CreatejobshomeState();
}

class _CreatejobshomeState extends State<Createjobshome> {
  int _userid = userID;
  String _salary;
  String _location;
  String _schedule;
  String _title;
  String _cate;
  String _quota;
  String _desc;
  String _exp;
  String _edu;
  _sendReinfo() async {
    var apiUrl = "${baseUrl}register?";
    var result = await http.post(apiUrl, body: {
      "userid": _userid,
      "salary": _salary,
      "location": _location,
      "schedule": _schedule,
      "title": _title,
      "cate": _cate,
      "quota": _quota,
      "desc": _desc,
      "exp": _exp,
      "edu": _edu,
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
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 30),
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
                "发布招聘",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        //上下左右各添加16像素补白
        padding: EdgeInsets.only(top: 1),
        child: Container(
          height: 550,
          width: 400,
          child: ListView(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Cate（请输入工种）",
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
                  _cate = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入标题（简洁明了）",
                  prefixIcon: Icon(Icons.title),
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
                  _title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入薪资",
                  prefixIcon: Icon(Icons.card_giftcard),
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
                  _salary = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入位置",
                  prefixIcon: Icon(Icons.location_city),
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
                  _location = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入职位描述",
                  prefixIcon: Icon(Icons.details),
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
                  _desc = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入时间计划",
                  prefixIcon: Icon(Icons.details),
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
                  _schedule = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入经验要求",
                  prefixIcon: Icon(Icons.details),
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
                  _exp = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入学历要求",
                  prefixIcon: Icon(Icons.details),
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
                  _edu = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "请输入招聘人数",
                  prefixIcon: Icon(Icons.details),
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
                  _quota = value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: RaisedButton.icon(
                  icon: Icon(Icons.done_all),
                  label: Text(
                    "同意招聘协议并发布",
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  onPressed: () {
                    _sendReinfo();
                    runApp(FlMainpage());
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
      ),
    ]);
  }
}
