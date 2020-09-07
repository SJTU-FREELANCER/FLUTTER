import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freelancer/sharedinfo/user_info.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../sharedinfo/config.dart';
import 'package:freelancer/Homepage/detail_job.dart'; //每个新建的都要引入

var _refreshi = -20;

class Jobs extends StatefulWidget {
  Jobs({Key key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  //filter info added?
  bool _needFilter = false;
  String _fsalary;
  String _fcate;
  String _flocation;
  String _ftitle;
  String _fexp;
  String _fedu;
  var _recid;

  var para = new Map<String, String>();

  //get jobs without filter info
  List<Widget> joblist = new List();
  _getCards() async {
    List<Widget> list = new List();

    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.responseType = ResponseType.plain;

    Response result;
    result = await dio.post("/get_jobs");

    // Utf8Decoder decode = new Utf8Decoder();

    if (result.statusCode == 200) {
      List tmp = jsonDecode(result.data);
      print("json type is: ${tmp.runtimeType}");
      _refreshi += 20;
      _refreshi = _refreshi % 1000;

      for (int i = 0 + _refreshi; i <= _refreshi + 20; i++) {
        var index = tmp[i];
        var salary = index["rec_salary"];
        var location = index["rec_Location"];
        var title = index["rec_Title"];
        var cate = index["rec_Cate"];
        var enrolled = index["rec_Enrolled"];
        var education = index["rec_Education"];
        var experience = index["rec_Experience"];

        _recid = index["rex_ID"];
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
                          color: Colors.lightGreen,
                          child: Text("申请",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {
                            _addApplyInfo();
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
        joblist = list;
      });
    } else {
      print(result.statusCode);
    }
  }

  _filteredCards() async {
    List<Widget> list = new List();

    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.responseType = ResponseType.plain;

    Response fresult;
    fresult = await dio.post("/filt_jobs", data: para);

    // Utf8Decoder decode = new Utf8Decoder();

    if (fresult.statusCode == 200) {
      List tmp = jsonDecode(fresult.data);
      print("json type is: ${tmp.runtimeType}");
      print(tmp.length);

      for (int i = 0; i < tmp.length; i++) {
        var index = tmp[i];
        var salary = index["rec_salary"];
        var location = index["rec_Location"];
        var title = index["rec_Title"];
        var cate = index["rec_Cate"];
        var enrolled = index["rec_Enrolled"];
        var education = index["rec_Education"];
        var experience = index["rec_Experience"];
        _recid = index["rec_ID"];

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
                          color: Colors.lightGreen,
                          child: Text("申请",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: _addApplyInfo,
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
        joblist = list;
      });
    } else {
      print(fresult.statusCode);
    }
  }

  _getSearchResult() async {
    List<Widget> list = new List();

    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.responseType = ResponseType.plain;

    Response fresult;
    fresult = await dio.post("/filt_jobs", data: para);

    // Utf8Decoder decode = new Utf8Decoder();

    if (fresult.statusCode == 200) {
      List tmp = jsonDecode(fresult.data);
      print("json type is: ${tmp.runtimeType}");
      print(tmp.length);

      for (int i = 0; i < tmp.length; i++) {
        var index = tmp[i];
        var salary = index["rec_salary"];
        var location = index["rec_Location"];
        var title = index["rec_Title"];
        var cate = index["rec_Cate"];
        var enrolled = index["rec_Enrolled"];
        var education = index["rec_Education"];
        var experience = index["rec_Experience"];
        _recid = index["rec_ID"];

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
                          color: Colors.lightGreen,
                          child: Text("申请",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: _addApplyInfo,
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
        joblist = list;
      });
    } else {
      print(fresult.statusCode);
    }
  }

  _addApplyInfo() async {
    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri = Uri.http(serviceUri, "/add_apply_info",
        {"user_id": userID.toString(), "rec_id": _recid.toString()});
    result = await Dio().get("$uri", options: options);

    if (result.statusCode == 200) {
      print("success");
    } else {
      print(result.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCards();
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
                icon: Icon(Icons.filter_list),
                onPressed: _onAdd,
              ),
            ),
            Container(
              height: 60,
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "find some jobs by title",
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    // onPressed: _getSearchResult(),
                  ),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[300]),
                  ),
                ),
                // onChanged: (value) {
                //   para["title"] = value;
                // },
              ),
            ),
          ],
        ),
        Container(
          height: 485,
          width: 400,
          child: ListView(
            children: joblist,
          ),
        ),
      ],
    );
  }

  void _onAdd() {
    print("$_needFilter");
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('请填写筛选信息'),
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "salary",
                    hintText: "e.g:5000-6000",
                    icon: Icon(Icons.person),
                  ),
                  onChanged: (value) {
                    _fsalary = value;
                    if (_fsalary != null) para["salary"] = _fsalary;
                  }),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "cate",
                    hintText: "e.g:钟点工",
                    icon: Icon(Icons.lock)),
                onChanged: (value) {
                  _fcate = value;
                  if (_fcate != null) para["cate"] = _fcate;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "location",
                    hintText: "e.g:徐汇",
                    icon: Icon(Icons.phone_iphone)),
                onChanged: (value) {
                  setState(() {
                    _flocation = value;
                    if (_fcate != null) para["location"] = _flocation;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "title",
                    hintText: "e.g:五险一金包吃住钟点工",
                    icon: Icon(Icons.mail_outline)),
                onChanged: (value) {
                  _ftitle = value;
                  if (_ftitle != null) para["title"] = _ftitle;
                },
              ),
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
                    _needFilter = true;
                    print(" set needFilter");
                    _filteredCards();
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
                    _needFilter = false;
                    print(" reset needFilter");
                    _getCards();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }
}
