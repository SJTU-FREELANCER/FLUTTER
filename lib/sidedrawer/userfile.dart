import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/sharedinfo/config.dart';
import 'package:freelancer/sharedinfo/user_info.dart';

import '../Homepage/mainpage.dart';

class FlFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: FormUserfile(),
    );
  }
}

class FormUserfile extends StatefulWidget {
  @override
  _FormUserfile createState() => new _FormUserfile();
}

class _FormUserfile extends State<FormUserfile> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _pwdnController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _mailController = new TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();

  var reset_name = userName;
  var reset_password;
  var confirm_password = userPassword;
  var reset_phone = userPhone;
  var reset_email = userEmail;

  _editMyinfo() async {
    Options options =
        Options(headers: {HttpHeaders.authorizationHeader: "Bearer $secToken"});
    options.responseType = ResponseType.plain;
    Response result;
    var uri = Uri.http(serviceUri, "/alter_user_info", {
      "userid": userID.toString(),
      "username": reset_name.toString(),
      "password": reset_password,
      "phone": reset_phone,
      "email": reset_email,
      "role": userStatus.toString(),
    });
    result = await Dio().get("$uri", options: options);
    if (result.statusCode == 200) {
      print("success");
    } else {
      print(result.statusCode);
    }
  }

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
                        "个人信息",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "$userName",
                    icon: Icon(Icons.person)),
                // 校验用户名
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
                onChanged: (value) {
                  reset_name = value;
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "原密码",
                    hintText: "用以验证身份",
                    icon: Icon(Icons.lock)),
                obscureText: true,
                //校验密码
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
                onChanged: (value) {
                  confirm_password = value;
                },
              ),
              TextFormField(
                controller: _pwdnController,
                decoration: InputDecoration(
                    labelText: "新密码",
                    hintText: "不能少于6位",
                    icon: Icon(Icons.lock)),
                obscureText: true,
                //校验密码
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
                onChanged: (value) {
                  reset_password = value;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: "手机号",
                    hintText: "$userPhone",
                    icon: Icon(Icons.phone_iphone)),
                // obscureText: true,
                //校验手机号
                validator: (v) {
                  return v.trim().length == 11 ? null : "手机号长度有误";
                },
                onChanged: (value) {
                  reset_phone = value;
                },
              ),
              TextFormField(
                  controller: _mailController,
                  decoration: InputDecoration(
                      labelText: "邮箱",
                      hintText: "$userEmail",
                      icon: Icon(Icons.mail_outline)),
                  // obscureText: true,
                  //校验手机号
                  validator: (v) {
                    return v.trim().contains("@") ? null : "请加上邮箱后缀";
                  },
                  onChanged: (value) {
                    reset_email = value;
                  }),
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
                          if (confirm_password == userPassword) {
                            //验证通过提交数据
                            _editMyinfo();
                            showDialog<Null>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  title: new Text('修改结果'),
                                  content: new SingleChildScrollView(
                                    child: new ListBody(
                                      children: <Widget>[
                                        new Text('您已经完成修改，请返回查看！'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text('返回'),
                                      onPressed: () {
                                        runApp(FlMainpage());
                                      },
                                    ),
                                  ],
                                );
                              },
                            ).then((val) {
                              print(val);
                            });
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
