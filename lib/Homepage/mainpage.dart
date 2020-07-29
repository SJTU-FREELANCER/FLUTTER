import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:freelancer/Homepage/create_applicants.dart';
import 'package:freelancer/Homepage/create_jobs.dart';
import 'package:freelancer/sharedinfo/user_info.dart';
import 'package:freelancer/sidedrawer/recieved_offer.dart';
import 'package:freelancer/startup/login.dart';
import 'package:freelancer/sidedrawer/managepage.dart';
import 'package:freelancer/sidedrawer/myapplicants.dart';
import 'package:freelancer/sidedrawer/mylike.dart';
import 'package:freelancer/sidedrawer/myrecruit.dart';
import 'package:freelancer/sidedrawer/userfile.dart';
import 'package:freelancer/sidedrawer/userfileM.dart';
import 'package:freelancer/Homepage/hp_job.dart';
import 'package:freelancer/Homepage/hp_app.dart';

class FlMainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CN'),
        const Locale('en', 'US'),
      ],
      home: ScaffoldRoute(),
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;

  final List<Widget> _children = [Jobs(), Applicants()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.person, color: Colors.green[300]), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
          "FREELANCER",
          style: TextStyle(
            color: Colors.green[300],
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.green[200],
        ),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      drawer: new MyDrawer(), //抽屉
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            title: Text('JOBS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('APPLICANTS'),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.green[200],
        onTap: _onItemTapped,
      ),
      body: _children[_selectedIndex],
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[300],
          foregroundColor: Colors.green[200],
          onPressed: _onAdd),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('请选择要发布的信息'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                  runApp(Createapplicants());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('找工作'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                  runApp(Createjobs());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('找人才'),
                ),
              ),
            ],
          );
        });
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerlist = <Widget>[
      ListTile(
        leading: const Icon(
          Icons.face,
          color: Colors.pink,
        ),
        title: const Text('用户信息'),
        onTap: () {
          runApp(FlFile());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.folder_shared,
          color: Colors.deepOrange,
        ),
        title: const Text('简历资料'),
        onTap: () {
          runApp(FlFileM());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        title: const Text('我的收藏'),
        onTap: () {
          runApp(Mylikes());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.swap_horizontal_circle,
          color: Colors.blue,
        ),
        title: const Text('我的招聘'),
        onTap: () {
          runApp(FlMyRecruit());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.dock,
          color: Colors.indigo,
        ),
        title: const Text('我的应聘'),
        onTap: () {
          runApp(FlMyApplicants());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.file_upload,
          color: Colors.purpleAccent,
        ),
        title: const Text('我的offer'),
        onTap: () {
          runApp(FlRecievedOffer());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.undo,
          color: Colors.green,
        ),
        title: const Text('退出登录'),
        onTap: () {
          runApp(FlLogin());
        },
      ),
    ];
    if (userStatus == 2) {
      drawerlist.add(ListTile(
        leading: const Icon(
          Icons.gps_fixed,
          color: Colors.purple,
        ),
        title: const Text('管理员工具'),
        onTap: () {
          if (userStatus == 2) {
            runApp(Flmanage());
          } else {
            print("$userStatus");
            runApp(FlMainpage());
          }
        },
      ));
    }
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/e.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "$userName",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: drawerlist,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
