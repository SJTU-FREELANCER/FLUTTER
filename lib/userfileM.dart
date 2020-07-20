import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:freelancer/config.dart';
import 'package:freelancer/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'mainpage.dart';

int _userid = userID;
String _name;
bool _gender;
String _birth;
String _experience;
String _education;

class FlFileM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: FormUserM(),
    );
  }
}

class FormUserM extends StatefulWidget {
  @override
  _FormUserM createState() => new _FormUserM();
}

class _FormUserM extends State<FormUserM> {
  _updateResume() async {
    var apiUrl = "${baseUrl}alter_resume";
    var result = await http.post(apiUrl, body: {
      "user_id": "$_userid",
      "name": "$_name",
      "gender": "$_gender",
      "birth": "$_birth",
      "experience": "$_experience",
      "education": "$_education"
    });
    if (result.statusCode == 200) {
      print("success");
    } else {
      print(result.statusCode);
    }
  }

  TextEditingController _unameController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: ListView(
            children: <Widget>[
              BackupTitle(),
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: "$username",
                    labelStyle: TextStyle(color: Colors.deepOrange[600]),
                    hintText: "修改姓名",
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.deepOrange[600],
                    )),
                // 校验用户名
                validator: (v) {
                  return v.trim().length > 0 ? null : "姓名不能为空";
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              //性别
              Container(
                child: SexM(),
              ),
              Container(
                child: Birthdate(),
              ),
              Container(
                child: EducationM(),
              ),
              Container(
                child: ExperienceM(),
              ),
              // 修改按钮

              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("修改"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            print(_birth is String);
                            _updateResume();
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackupTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
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
              "简历资料",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}

class SexM extends StatefulWidget {
  @override
  _SexM createState() => new _SexM();
}

class _SexM extends State<SexM> {
  int groupValuea = 1;
  // int groupValueb = 0;
  // String str = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text(
          '性别',
          style: TextStyle(color: Colors.deepOrange[600]),
        ),
        SizedBox(
          width: 50,
        ),
        Text('男'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 1,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _gender = true;
            });
          },
        ),
        Text('女'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 2,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _gender = false;
            });
          },
        ),
      ],
    );
  }
}

class EducationM extends StatefulWidget {
  @override
  _EducationM createState() => new _EducationM();
}

class _EducationM extends State<EducationM> {
  int groupValuea = 1;
  int groupValueb = 0;
  String str = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text(
          '教育背景',
          style: TextStyle(
            color: Colors.deepOrange[600],
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text('高中及以下'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 1,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _education = "高中及以下";
            });
          },
        ),
        Text('本科'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 2,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _education = "本科";
            });
          },
        ),
        Text('大专'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 3,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _education = "大专";
            });
          },
        ),
      ],
    );
  }
}

class ExperienceM extends StatefulWidget {
  @override
  _ExperienceM createState() => new _ExperienceM();
}

class _ExperienceM extends State<ExperienceM> {
  int groupValuea = 1;
  int groupValueb = 0;
  String str = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text(
          '工作经验',
          style: TextStyle(color: Colors.deepOrange[600]),
        ),
        SizedBox(
          width: 8,
        ),
        Text('一年'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 1,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _experience = '一年';
            });
          },
        ),
        Text('两年'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 2,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _experience = '两年';
            });
          },
        ),
        Text('三年及以上'),
        Radio(
          activeColor: Colors.deepOrange[600],
          value: 3,
          groupValue: this.groupValuea,
          onChanged: (v) {
            setState(() {
              this.groupValuea = v;
              _experience = '三年及以上';
            });
          },
        ),
      ],
    );
  }
}

class Birthdate extends StatefulWidget {
  Birthdate({Key key}) : super(key: key);

  @override
  _BirthdateState createState() => _BirthdateState();
}

class _BirthdateState extends State<Birthdate> {
  DateTime _dateTime = DateTime.now();
  _showDatepicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('custom Done', style: TextStyle(color: Colors.red)),
      ),
      minDateTime: DateTime.parse("1940-07-15"),
      maxDateTime: DateTime.parse("2020-07-15"),
      initialDateTime: DateTime.parse("2020-07-15"),
      dateFormat: "yyyy-MMMM-dd",
      locale: DateTimePickerLocale.zh_cn,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          String year = dateTime.year.toString();
          String months = dateTime.month.toString();
          String day = dateTime.day.toString();
          _birth = year + "-" + months + "-" + day;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          String year = dateTime.year.toString();
          String months = dateTime.month.toString();
          String day = dateTime.day.toString();
          _birth = year + "-" + months + "-" + day;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "出生日期",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.deepOrange[600],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                child: Row(
                  children: [
                    Text(
                      "$_birth",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                onTap: _showDatepicker,
              )
            ],
          )
        ],
      ),
    );
  }
}
