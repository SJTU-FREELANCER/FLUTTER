import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/detail_job.dart';

import 'dart:convert';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';
import 'package:http/http.dart' as http;

import '../Homepage/mainpage.dart';

class FlMyApplicants extends StatelessWidget {
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

  List<Widget> myRecslist = new List();
  var para = new Map<String, String>();

  _deleteApp(int rid) async {
    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri = Uri.http(serviceUri, "/delete_apply_info",
        {"rec_id": rid.toString(), "user_id": userID.toString()});
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
        Uri.http(serviceUri, "/getAppbyId", {"userid": userID.toString()});
    result = await Dio().get("$uri", options: options);

    if (result.statusCode == 200) {
      List tmp = jsonDecode(result.data);
      print("json type is: ${tmp.runtimeType}");

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
          acceptedshow = "待审核";
        else if (accepted == 1)
          acceptedshow = "已通过";
        else {
          acceptedshow = "未通过";
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
                          child: Text("取消",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {
                            _deleteApp(_recid);
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
                              "应聘信息",
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
