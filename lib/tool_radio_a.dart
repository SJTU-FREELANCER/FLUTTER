import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int groupValuea = 1;
  int groupValueb = 0;
  String str = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Radio 单选按钮'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text('请选择性别：'),
              SizedBox(
                width: 8,
              ),
              Text('男'),
              Radio(
                value: 1,
                groupValue: this.groupValuea,
                onChanged: (v) {
                  setState(() {
                    this.groupValuea = v;
                  });
                },
              ),
              Text('女'),
              Radio(
                value: 2,
                groupValue: this.groupValuea,
                onChanged: (v) {
                  setState(() {
                    this.groupValuea = v;
                  });
                },
              ),
              Text('人妖'),
              Radio(
                value: 3,
                groupValue: this.groupValuea,
                onChanged: (v) {
                  setState(() {
                    this.groupValuea = v;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '驾驶机动车在下列哪种路段不得超车？',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          RadioListTile(
            value: 1,
            groupValue: this.groupValueb,
            title: Text('A：山区道路'),
            onChanged: (v) {
              setState(() {
                this.groupValueb = v;
                str = '滋滋 回答错误';
              });
            },
          ),
          RadioListTile(
            value: 2,
            groupValue: this.groupValueb,
            title: Text('B：城市高架路'),
            onChanged: (v) {
              setState(() {
                this.groupValueb = v;
                str = '滋滋 回答错误';
              });
            },
          ),
          RadioListTile(
            value: 3,
            groupValue: this.groupValueb,
            title: Text('C：城市快速路'),
            onChanged: (v) {
              setState(() {
                this.groupValueb = v;
                str = '滋滋 回答错误';
              });
            },
          ),
          RadioListTile(
            value: 4,
            groupValue: this.groupValueb,
            title: Text('D：窄桥、弯道'),
            onChanged: (v) {
              setState(() {
                this.groupValueb = v;
                str = '恭喜回答正确';
              });
            },
          ),
          Text(
            '$str',
            style: TextStyle(color: Colors.red),
          ),
        ],
      )),
    );
  }
}

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected, //当前状态
          onChanged: (value) {
            //重新构建页面
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        )
      ],
    );
  }
}
