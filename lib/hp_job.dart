import 'package:flutter/material.dart';
import 'package:freelancer/detail_job.dart'; //每个新建的都要引入

class Jobs extends StatefulWidget {
  Jobs({Key key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  List getData() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
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
        Card(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          elevation: 15.0,
          child: Column(
            children: [
              ListTile(
                title: Text("钟点工|饮品店帮工一天包餐"),
                subtitle: Text("200元/天"),
                trailing: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 15,
                      child: Text(
                        "2442人看过",
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
                      "闵行",
                      style:
                          TextStyle(fontSize: 14, color: Colors.indigoAccent),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 300),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: IconButton(
                        color: Colors.indigoAccent,
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () {
                          runApp(Jobdetail());
                        },
                      ),
                    ),
                  ),
                ],
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
      ],
    );
  }
}
