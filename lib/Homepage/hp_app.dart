import 'dart:convert';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:freelancer/Homepage/detail_job.dart'; //每个新建的都要引入

var _refreshi = -20;

class Applicants extends StatefulWidget {
  Applicants({Key key}) : super(key: key);

  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  String _fexp;
  String _fedu;
  var para = new Map<String, String>();

  List<Widget> applist = new List();
  _getApps() async {
    List<Widget> list = new List();
    var apiUrl = "${baseUrl}get_applicants";
    var result = await http.get(apiUrl);
    Utf8Decoder decode = new Utf8Decoder();
    if (result.statusCode == 200) {
      print(jsonDecode(decode.convert(result.bodyBytes)) is List);
      List tmp = jsonDecode(decode.convert(result.bodyBytes));
      _refreshi += 20;
      for (int i = 0 + (_refreshi % 1000); i <= (_refreshi + 20) % 1000; i++) {
        var index = tmp[i];
        var name = index["name"];
        var education = index["education"];
        var birth = index["birth"];
        var gender = index["gender"];
        var genders = gender ? "男" : "女";
        var experience = index["experience"];
        var user_Id = index["user_Id"];
        list.add(
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            elevation: 15.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("$education|$experience 经验"),
                  subtitle: Text("$genders"),
                  trailing: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 15,
                        child: Text(
                          "$birth",
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
                          color: Colors.lightGreen,
                          child: Text("招聘",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {},
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
                        "$name",
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
                        "一点点总部",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 250),
                      child: Text(
                        "29分钟前",
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
        applist = list;
      });
    } else {
      print(result.statusCode);
    }
  }

  _filteredApps() async {
    List<Widget> list = new List();
    var fresult;
    var uri = Uri.http("10.0.2.2:8080", "/filt_applicants", para);

    fresult = await http.get(uri);

    Utf8Decoder decode = new Utf8Decoder();
    if (fresult.statusCode == 200) {
      print(jsonDecode(decode.convert(fresult.bodyBytes)) is List);
      List tmp = jsonDecode(decode.convert(fresult.bodyBytes));

      print(tmp.length);

      for (int i = 0; i < tmp.length; i++) {
        var index = tmp[i];
        var name = index["name"];
        var education = index["education"];
        var birth = index["birth"];
        var gender = index["gender"];
        var genders = gender ? "男" : "女";
        var experience = index["experience"];
        // var user_Id = index["user_Id"];
        list.add(
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            elevation: 15.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("$education|$experience 经验"),
                  subtitle: Text("$genders"),
                  trailing: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 15,
                        child: Text(
                          "$birth",
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
                          color: Colors.lightGreen,
                          child: Text("招聘",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {},
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
                        "$name",
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
                        "一点点总部",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 250),
                      child: Text(
                        "29分钟前",
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
        applist = list;
      });
    } else {
      print(fresult.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    _getApps();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              height: 20,
              width: 40,
              child: IconButton(
                icon: Icon(
                  Icons.filter_list,
                ),
                onPressed: _onAdd,
              ),
            ),
            Container(
              height: 60,
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "find some applicants",
                  prefixIcon: Icon(Icons.search),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[300]),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 485,
          width: 400,
          child: ListView(
            children: applist,
          ),
        ),
      ],
    );
  }

  void _onAdd() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('请填写筛选信息'),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "experience",
                    hintText: "e.g:两年",
                    icon: Icon(Icons.phone_iphone)),
                onChanged: (value) {
                  _fexp = value;
                  if (_fexp != null) para["experience"] = _fexp;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "education",
                    hintText: "e.g:本科",
                    icon: Icon(Icons.mail_outline)),
                onChanged: (value) {
                  _fedu = value;
                  if (_fedu != null) para["education"] = _fedu;
                },
              ),
              Container(
                width: 40,
                height: 40,
                child: RaisedButton(
                  child: Text("提交",
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  onPressed: () {
                    print(" set needFilter");
                    _filteredApps();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 40,
                height: 40,
                child: RaisedButton(
                  child: Text("取消筛选",
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  onPressed: () {
                    print(" reset needFilter");
                    _getApps();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }
}
