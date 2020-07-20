import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'config.dart';
import 'package:freelancer/detail_job.dart'; //每个新建的都要引入

var _refreshi = -20;
var currecID;

class Jobs extends StatefulWidget {
  Jobs({Key key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  //filter info added?
  bool _needFilter = false;
  var _fsalary;
  var _fcate;
  var _flocation;
  var _ftitle;
  var _fexp;
  var _fedu;

  //get jobs without filter info
  List<Widget> joblist = new List();
  _getCards() async {
    List<Widget> list = new List();
    var apiUrl = "${baseUrl}get_jobs";
    var apiUrlf = "${baseUrl}filt_jobs";
    var result;
    if (_needFilter) {
      result = await http.post(apiUrlf, body: {
        "salary": "$_fsalary",
        "cate": "$_fcate",
        "location": "$_flocation",
        "title": "$_ftitle",
        "exprience": "$_fexp",
        "education": "$_fedu",
      });
    } else {
      result = await http.get(apiUrl);
    }

    Utf8Decoder decode = new Utf8Decoder();
    if (result.statusCode == 200) {
      print(jsonDecode(decode.convert(result.bodyBytes)) is List);
      List tmp = jsonDecode(decode.convert(result.bodyBytes));
      _refreshi += 20;
      for (int i = 0 + (_refreshi % 1000); i <= (_refreshi + 20) % 1000; i++) {
        var index = tmp[i];
        var salary = index["rec_salary"];
        var location = index["rec_Location"];
        var title = index["rec_Title"];
        var cate = index["rec_Cate"];
        var enrolled = index["rec_Enrolled"];
        list.add(
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            elevation: 15.0,
            child: Column(
              children: [
                ListTile(
                  title: Text("$cate|$title"),
                  subtitle: Text("$salary"),
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
                                recedu: index["rec_Education"],
                                recexp: index["rec_Experience"],
                                recdes: index["rec_Desc"],
                              ),
                            ));
                        // runApp(Jobdetail());
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
        joblist = list;
      });
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
                  labelText: "find some jobs",
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
            children: joblist,
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
              // SimpleDialogOption(
              //   onPressed: () {
              //     // 返回1
              //     Navigator.pop(context, 1);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 6),
              //     child: const Text('找工作'),
              //   ),
              // ),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "salary",
                  hintText: "e.g:5000-6000",
                  icon: Icon(Icons.person),
                ),
                onChanged: (value) {
                  _fsalary = value;
                },
                // 校验用户名
                // validator: (v) {
                //   return v.trim().length > 0 ? null : "用户名不能为空";
                // }
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "cate",
                    hintText: "e.g:钟点工",
                    icon: Icon(Icons.lock)),
                onChanged: (value) {
                  _fcate = value;
                },
                obscureText: true,
                //校验密码
                // validator: (v) {
                //   return v.trim().length > 5 ? null : "密码不能少于6位";
                // }
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "location",
                    hintText: "e.g:徐汇",
                    icon: Icon(Icons.phone_iphone)),
                onChanged: (value) {
                  _flocation = value;
                },
                obscureText: true,
                //校验手机号
                // validator: (v) {
                //   return v.trim().length == 11 ? null : "手机号长度有误";
                // }
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "title",
                    hintText: "e.g:五险一金包吃住钟点工",
                    icon: Icon(Icons.mail_outline)),
                onChanged: (value) {
                  _ftitle = value;
                },
                obscureText: true,
                //校验手机号
                // validator: (v) {
                //   return v.trim().contains("@") ? null : "请加上邮箱后缀";
                // }
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "experience",
                    hintText: "e.g:两年",
                    icon: Icon(Icons.phone_iphone)),
                onChanged: (value) {
                  _fexp = value;
                },
                obscureText: true,
                //校验手机号
                // validator: (v) {
                //   return v.trim().length == 11 ? null : "手机号长度有误";
                // }
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "education",
                    hintText: "e.g:本科",
                    icon: Icon(Icons.mail_outline)),
                onChanged: (value) {
                  _fedu = value;
                },
                obscureText: true,
                //校验手机号
                // validator: (v) {
                //   return v.trim().contains("@") ? null : "请加上邮箱后缀";
                // }
              ),
              Container(
                width: 40,
                height: 40,
                child: RaisedButton(
                  child: Text("提交",
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                  onPressed: () => _datastate,
                ),
              ),

              // SimpleDialogOption(
              //   onPressed: () {
              //     // 返回2
              //     Navigator.pop(context, 2);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 6),
              //     child: const Text('找人才'),
              //   ),
              // ),
            ],
          );
        });
  }

  _datastate() {
    _needFilter = true;
  }
}
