import 'package:flutter/material.dart';

var _cate;
var _title;
var _salary;

var _recedu;
var _recexp;
var _recdes;

class Jobdetail extends StatefulWidget {
  var reccate;
  var rectitle;
  var recsalary;

  var recedu;
  var recexp;
  var recdes;

  Jobdetail({
    Key key,
    @required this.reccate,
    @required this.rectitle,
    @required this.recsalary,
    @required this.recedu,
    @required this.recexp,
    @required this.recdes,
  }) : super(key: key);

  @override
  _JobdetailState createState() => _JobdetailState();
}

class _JobdetailState extends State<Jobdetail> {
  @override
  void initState() {
    // TODO: implement initState
    _cate = widget.reccate;
    _title = widget.rectitle;
    _salary = widget.recsalary;

    _recdes = widget.recdes;
    _recedu = widget.recedu;
    _recexp = widget.recexp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 30,
                  ),
                  child: Text(
                    "工作详情",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            //导航栏右侧菜单
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {/*_addtomylikes*/},
            ),
          ],
        ),
        body: JobdetailBody(),
      ),
    );
  }
}

class JobdetailBody extends StatefulWidget {
  JobdetailBody({Key key}) : super(key: key);

  @override
  _JobdetailBodyState createState() => _JobdetailBodyState();
}

class _JobdetailBodyState extends State<JobdetailBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Details(),
        JobDescription(),
        Companydetail(),
      ],
    );
  }
}

class Details extends StatefulWidget {
  Details({Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _update = "刚刚";
  int _viewedtimes = 0;
  int _applicated = 0;
  String _worktime = "全周";
  String _workplace = "闵行郊区某路口";
  String _timelimit = "长期";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: [
          ListTile(
            title: Text("$_cate|$_title"),
            subtitle: Text("$_salary 元/月| 日结"),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  bottom: 8,
                ),
                child: Text("更新时间：$_update",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  bottom: 8,
                ),
                child: Text("浏览：$_viewedtimes 人",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  bottom: 8,
                ),
                child: Text("申请：$_applicated 人",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    )),
              )
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
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "教育要求：$_recedu",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "经验要求：$_recexp",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                  bottom: 8,
                ),
                child: Text(
                  "有效时间：$_timelimit",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class JobDescription extends StatefulWidget {
  JobDescription({Key key}) : super(key: key);

  @override
  _JobDescriptionState createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("职位描述"),
        subtitle: Text("$_recdes"),
      ),
    );
  }
}

class Companydetail extends StatefulWidget {
  Companydetail({Key key}) : super(key: key);

  @override
  _CompanydetailState createState() => _CompanydetailState();
}

class _CompanydetailState extends State<Companydetail> {
  String _companyname = "上海市一点点饮品店";
  int _size = 10;
  String _kind = "私人经营";
  String _type = "餐饮娱乐";
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        children: [
          ListTile(
            title: Text("公司信息"),
          ),
          ListTile(
            title: Text("$_companyname"),
            subtitle: Text("企业认证"),
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
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "规模：$_size 人",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "性质：$_kind",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                  bottom: 8,
                ),
                child: Text(
                  "行业：$_type",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
