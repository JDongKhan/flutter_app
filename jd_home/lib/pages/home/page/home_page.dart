import 'package:flutter/material.dart';
import 'package:jd_core/style/jd_theme.dart';
import 'package:jd_home/demo/home_demo.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'home_main_page.dart';
import '../vm/home_view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();

  static _HomePageState of(BuildContext context) {
    return context.findAncestorStateOfType<_HomePageState>();
  }
}

class _HomePageState extends State<HomePage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver {
  TabController _tabController; //需要定义一个Controller

  List tabs = <Map<String, dynamic>>[
    {
      'title': '服务',
      'page': ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => HomeViewModel(),
        child: HomeMainPage(),
      ),
    },
    {'title': '案例', 'page': JDHomeDemo()},
    {'title': '严选', 'page': JDHomeDemo()}
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
          elevation: 0, //隐藏底部阴影
          leading: Builder(builder: (Bucontext) {
            return IconButton(
              icon: Icon(Icons.dashboard,
                  color: theme.navigationTextColor), //自定义图标
              onPressed: () {
                // 打开抽屉菜单
                ScaffoldState result =
                    context.findAncestorStateOfType<ScaffoldState>();
                result.openDrawer();
              },
            );
          }),

          title: TabBar(
              //生成Tab菜单
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: tabs.map((e) => Tab(text: e['title'])).toList()),

          actions: <Widget>[
            //导航栏右侧菜单
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share('我的应用很牛逼');
                }),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: tabs.map((e) {
            //创建3个Tab页
            return e['page'] as Widget;
          }).toList(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      print('app is background mode');
    } else if (state == AppLifecycleState.resumed) {
      print('app is back');
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  bool get wantKeepAlive => true;
}
