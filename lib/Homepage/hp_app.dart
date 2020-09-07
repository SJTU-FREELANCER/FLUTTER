import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';
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

    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.responseType = ResponseType.plain;

    Response result;
    result = await dio.post("/get_applicants");

    // Utf8Decoder decode = new Utf8Decoder();
    if (result.statusCode == 200) {
      List tmp = jsonDecode(result.data);
      print("json type is: ${tmp.runtimeType}");

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
                          onPressed: () {
                            _getMyrecs(user_Id);
                            _showSelection();
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

    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.responseType = ResponseType.plain;

    Response fresult;
    fresult = await dio.post("/filt_applicants", data: para);

    // Utf8Decoder decode = new Utf8Decoder();
    if (fresult.statusCode == 200) {
      // print(jsonDecode(decode.convert(fresult.bodyBytes)) is List);
      // List tmp = jsonDecode(decode.convert(fresult.bodyBytes));
      List tmp = jsonDecode(fresult.data);
      print("json type is: ${tmp.runtimeType}");
      print(tmp.length);

      for (int i = 0; i < tmp.length; i++) {
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
                          onPressed: () {
                            _getMyrecs(user_Id);
                            _showSelection();
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

  //for user to choose which
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

  _getMyrecs(int taruid) async {
    List<Widget> list = new List();

    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri =
        Uri.http(serviceUri, "/getRecbyId", {"userid": userID.toString()});
    result = await Dio().get("$uri", options: options);

    //Utf8Decoder decode = new Utf8Decoder();

    if (result.statusCode == 200) {
      List tmp = jsonDecode(result.data);
      print("json type is: ${tmp.runtimeType}");

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
                          child: Text("选择",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          onPressed: () {
                            _sendOffer(taruid, _recid);
                            Navigator.pop(context);
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
                      padding: EdgeInsets.only(left: 100),
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

  _sendOffer(int uid, int rid) async {
    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri = Uri.http(serviceUri, "/add_employ_info",
        {"user_id": uid.toString(), "rec_id": rid.toString()});
    result = await Dio().get("$uri", options: options);

    if (result.statusCode == 200) {
      print("success");
    } else {
      print(result.statusCode);
    }
  }

  void _showSelection() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('请选择职位'),
          children: myRecslist,
        );
      },
    );
  }
}
