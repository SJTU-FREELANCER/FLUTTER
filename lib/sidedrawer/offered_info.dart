import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

int tmprecid;
int taruserid;

class SDMyoffers extends StatefulWidget {
  int tarrecid;
  SDMyoffers({
    Key key,
    @required this.tarrecid,
  }) : super(key: key);

  @override
  _SDMyoffersState createState() => _SDMyoffersState();
}

class _SDMyoffersState extends State<SDMyoffers> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    tmprecid = widget.tarrecid;
    return SDMyappshome();
  }
}

class SDMyappshome extends StatefulWidget {
  @override
  _SDMyappshomeState createState() => new _SDMyappshomeState();
}

class _SDMyappshomeState extends State<SDMyappshome> {
  GlobalKey _formKey = new GlobalKey<FormState>();

  int isAccepted;

  List<Widget> tarApplist = new List();

  _setApp(int rid, int uid) async {
    var result;
    var uri = Uri.http("10.0.2.2:8080", "/update_apply_info", {
      "rec_id": rid.toString(),
      "user_id": uid.toString(),
      "accepted": isAccepted.toString(),
    });

    result = await http.get(uri);

    if (result.statusCode == 200) {
      print("success");
      _getMyApps();
    } else {
      print(result.statusCode);
    }
  }

  _getMyApps() async {
    List<Widget> list = new List();
    var result;
    Map<String, String> para = {"rec_id": tmprecid.toString()};

    var uri = Uri.http("10.0.2.2:8080", "/getMyEmployees", para);

    result = await http.get(uri);
    print(result);

    Utf8Decoder decode = new Utf8Decoder();

    if (result.statusCode == 200) {
      // print(jsonDecode(decode.convert(result.bodyBytes)) is List);
      List tmp = jsonDecode(decode.convert(result.bodyBytes));

      for (int i = 0; i < tmp.length; i++) {
        var index = tmp[i];

        var appname = index["name"];
        var appuserid = index["user_ID"];
        taruserid = appuserid;
        var appbirth = index["birth"];
        var apgender = index["gender"];
        var appgender = (apgender == "true") ? "男" : "女";

        var education = index["education"];
        var experience = index["experience"];
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
                  title: Text("$appname|$appgender"),
                  subtitle: Text("$appbirth"),
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
                          child: Text("审核",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {
                            _onshow(_recid, appuserid);
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
                        "自由",
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
                      onPressed: () {},
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
        tarApplist = list;
      });
    } else {
      print(result.statusCode);
    }
  }

  _onshow(int rid, int uid) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('请填写决策结果'),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "通过/驳回/审核中",
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
                setState(() {
                  if (value == "通过")
                    isAccepted = 1;
                  else if (value == "驳回")
                    isAccepted = 2;
                  else
                    isAccepted = 0;
                });
              },
            ),
            Container(
              width: 40,
              height: 40,
              child: RaisedButton(
                child: Text("提交",
                    style: TextStyle(fontSize: 12, color: Colors.white)),
                onPressed: () {
                  _setApp(rid, taruserid);
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
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              bottom: 30,
                            ),
                            child: Text(
                              "申请人信息",
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
              children: tarApplist,
            ),
          )
        ],
      ),
    );
  }
}
