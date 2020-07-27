import 'dart:convert';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';
import 'package:freelancer/sidedrawer/recruit_info.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/detail_job.dart';

import '../Homepage/mainpage.dart';

class FlMyRecruit extends StatelessWidget {
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

  _deleteRec(int rid) async {
    var result;
    var uri =
        Uri.http("10.0.2.2:8080", "/delete_rec", {"rec_id": rid.toString()});

    result = await http.get(uri);

    if (result.statusCode == 200) {
      print("success");
      _getMyrecs();
    } else {
      print(result.statusCode);
    }
  }

  _onshow(int rid) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('请填写更新后的招聘信息'),
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
                para["rec_Cate"] = _cate;
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
                para["rec_Title"] = _title;
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
                para["rec_Salary"] = _salary;
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
                para["rec_Location"] = _location;
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
                para["rec_Desc"] = _desc;
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
                para["rec_Timeschedule"] = _schedule;
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
                para["rec_Experience"] = _exp;
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
                para["rec_Education"] = _edu;
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
                para["rec_Quota"] = _quota;
              },
            ),
            Container(
              width: 40,
              height: 40,
              child: RaisedButton(
                child: Text("提交",
                    style: TextStyle(fontSize: 12, color: Colors.white)),
                onPressed: () {
                  _updateMyrec(rid);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }

  _updateMyrec(int rid) async {
    var result;
    para["rec_ID"] = rid.toString();
    para["user_ID"] = userID.toString();
    para["rec_Enrollled"] = null;

    var uri = Uri.http("10.0.2.2:8080", "/update_rec", para);

    result = await http.get(uri);

    if (result.statusCode == 200) {
      print("success");
      _getMyrecs();
    } else {
      print(result.statusCode);
    }
  }

  _getMyrecs() async {
    List<Widget> list = new List();

    var apiUrl = "${baseUrl}getRecbyId";
    var result;

    result = await http.post(apiUrl, body: {"userid": userID.toString()});
    Utf8Decoder decode = new Utf8Decoder();

    if (result.statusCode == 200) {
      print(jsonDecode(decode.convert(result.bodyBytes)) is List);
      List tmp = jsonDecode(decode.convert(result.bodyBytes));

      for (int i = 0; i < tmp.length; i++) {
        var index = tmp[i];
        var salary = index["rec_salary"];
        var location = index["rec_Location"];
        var title = index["rec_Title"];
        var cate = index["rec_Cate"];
        var enrolled = index["rec_Enrolled"];
        var education = index["rec_Education"];
        var experience = index["rec_Experience"];

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
                          "$enrolled 人进入",
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
                            _deleteRec(_recid);
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
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    RaisedButton(
                      child: Text("修改招聘信息"),
                      onPressed: () {
                        _onshow(_recid);
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    RaisedButton(
                      child: Text("查看应聘者"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => SDMyApplicants(
                                tarrecid: _recid,
                              ),
                            ));
                      },
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
    _getMyrecs();
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
                              "招聘信息",
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
