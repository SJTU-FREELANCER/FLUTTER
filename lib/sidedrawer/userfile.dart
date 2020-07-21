import 'package:flutter/material.dart';

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
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _mailController = new TextEditingController();

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
                      labelText: "userA(原用户名）",
                      hintText: "修改用户名",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "******",
                      hintText: "修改密码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: "13382270939",
                      hintText: "修改手机号",
                      icon: Icon(Icons.phone_iphone)),
                  obscureText: true,
                  //校验手机号
                  validator: (v) {
                    return v.trim().length == 11 ? null : "手机号长度有误";
                  }),
              TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: "userA@",
                      hintText: "修改手机号",
                      icon: Icon(Icons.mail_outline)),
                  obscureText: true,
                  //校验手机号
                  validator: (v) {
                    return v.trim().contains("@") ? null : "请加上邮箱后缀";
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
                          if ((_formKey.currentState as FormState).validate()) {
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
