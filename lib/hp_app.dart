import 'package:flutter/material.dart';
import 'package:freelancer/detail_job.dart'; //每个新建的都要引入

class Applicants extends StatefulWidget {
  Applicants({Key key}) : super(key: key);

  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
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
        ListTile(
          leading: IconButton(
            icon: Icon(Icons.star_border),
          ),
          title: Row(
            children: [
              Text("泥城|"),
              Text("汽修美容（中工）"),
              IconButton(
                icon: Icon(Icons.chat, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          subtitle: Text("4000-6000/月"),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () {
              runApp(Jobdetail());
            },
          ),
        ),
      ],
    );
  }
}
