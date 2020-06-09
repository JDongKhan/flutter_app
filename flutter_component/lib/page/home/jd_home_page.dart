import 'package:flutter/material.dart';
import 'package:flutter_component/global/jd_theme.dart';
import 'package:flutter_component/page/home/jd_home_main_page.dart';
import 'package:flutter_component/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../buiness/jd_business_page.dart';
import '../discover/jd_discover_page.dart';

class JDHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JDHomePageState();

  static _JDHomePageState of(BuildContext context) {
    return context.findAncestorStateOfType<_JDHomePageState>();
  }

}

class _JDHomePageState extends State<JDHomePage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {


  TabController _tabController; //需要定义一个Controller

  List tabs = <Map<String,dynamic>>[{
      'title' : '服务',
      'page' : ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context)=>HomeViewModel(),
        child: JDHomeMainPage(),
      ),
    }, {
      'title' : '案例',
      'page' : JDBusinessPage()
    },{
      'title' : '严选',
      'page' : JDDiscoverPage()
    }
  ];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    JDTheme theme = context.watch<JDTheme>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,//隐藏底部阴影
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.dashboard, color: theme.navigationTextColor), //自定义图标
              onPressed: () {
                // 打开抽屉菜单
                ScaffoldState result = context.findRootAncestorStateOfType<ScaffoldState>();
                result.openDrawer();
              },
            );
          }),

          title: TabBar(   //生成Tab菜单
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e['title'])).toList()
          ),

          actions: <Widget>[ //导航栏右侧菜单
            IconButton(icon: Icon(Icons.share), onPressed: () {
              Share.share('我的应用很牛逼');
            }),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) { //创建3个Tab页
            return  e['page'] as Widget;
          }).toList(),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;

}
