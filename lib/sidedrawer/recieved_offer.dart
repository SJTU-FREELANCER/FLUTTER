import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/detail_job.dart';

import 'dart:convert';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';
import 'package:http/http.dart' as http;

import '../Homepage/mainpage.dart';

class FlRecievedOffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: FormTestRoute(),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  GlobalKey _formKey = new GlobalKey<FormState>();

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

  int isAccepted;

  List<Widget> myRecslist = new List();
  var para = new Map<String, String>();
  _makeMyChoice(int rid, int uid, int iaflag) {
    List<DropdownMenuItem<int>> choiceitem = [];

    choiceitem.add(DropdownMenuItem(value: 0, child: Text("待审核")));
    choiceitem.add(DropdownMenuItem(value: 1, child: Text("已同意")));
    choiceitem.add(DropdownMenuItem(value: 2, child: Text("已拒绝")));

    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              Container(
                height: 50,
                width: 50,
                child: DropdownButton(
                  value: 2,
                  items: choiceitem,
                  onChanged: (value) {
                    setState(() {
                      iaflag = value;
                    });
                    print("$iaflag");
                  },
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text("确定"),
                  onPressed: () {
                    _makeMyDecision(rid, uid, iaflag);
                  },
                ),
              )
            ],
          );
        });
  }

  _makeMyDecision(int rid, int uid, int iaflag) async {
    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri = Uri.http(serviceUri, "/update_employ_info", {
      "rec_id": rid.toString(),
      "user_id": uid.toString(),
      "accepted": iaflag.toString()
    });
    result = await Dio().get("$uri", options: options);

    if (result.statusCode == 200) {
      print("success");
      _getMyApps();
    } else {
      print(result.statusCode);
    }
  }

  _getMyApps() async {
    List<Widget> list = new List();

    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri =
        Uri.http(serviceUri, "/getEmpbyId", {"userid": userID.toString()});
    result = await Dio().get("$uri", options: options);

    if (result.statusCode == 200) {
      print(jsonDecode(result.data) is List);
      List tmp = jsonDecode(result.data);

      for (int i = 0; i < tmp.length; i++) {
        var index = tmp[i];
        var salary = index["rec_Salary"];
        var location = index["rec_Location"];
        var title = index["rec_Title"];
        var cate = index["rec_Cate"];
        var enrolled = index["rec_Enrolled"];
        var education = index["rec_Education"];
        var experience = index["rec_Experience"];
        var accepted = index["accepted"];

        String acceptedshow;
        if (accepted == 0)
          acceptedshow = "待考察";
        else if (accepted == 1)
          acceptedshow = "已同意";
        else {
          acceptedshow = "已拒绝";
        }

        var _recid = index["rec_ID"];

        list.add(
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            elevation: 15.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("$cate|$title"),
                  subtitle: Text("$salary 元/月"),
                  trailing: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 15,
                        child: Text(
                          "$acceptedshow",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text("选择",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {
                            _makeMyChoice(_recid, userID, isAccepted);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        bottom: 3,
                      ),
                      child: Text(
                        "$location",
                        style:
                            TextStyle(fontSize: 14, color: Colors.indigoAccent),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 350),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      color: Colors.indigoAccent,
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new Jobdetail(
                                reccate: index["rec_Cate"],
                                rectitle: index["rec_Title"],
                                recsalary: index["rec_salary"],
                                recedu: index["rec_Education"],
                                recexp: index["rec_Experience"],
                                recdes: index["rec_Desc"],
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                  indent: 20.0,
                  endIndent: 20,
                  color: Colors.blueGrey,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 3,
                        bottom: 5,
                      ),
                      child: Text(
                        "教育：$education",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 230),
                      child: Text(
                        "经验：$experience",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      setState(() {
        myRecslist = list;
      });
    } else {
      print(result.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    _getMyApps();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            width: 400,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidate: true, //开启自动校验
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
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
                              "收到的offer",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 400,
            width: 400,
            child: ListView(
              children: myRecslist,
            ),
          )
        ],
      ),
    );
  }
}
