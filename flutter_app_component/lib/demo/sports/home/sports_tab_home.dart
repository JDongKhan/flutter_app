import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/vm/sports_tab_home_vm.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:provider/provider.dart';

import 'page/sports_home_page.dart';
import 'page/sports_home_tv_page.dart';
import 'page/sports_home_video_page.dart';

/**
 *
 * @author jd
 *
 */

class TabHomePage extends StatefulWidget {
  const TabHomePage();

  final String title = 'jd_tab_home';

  static build() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SportsTabHomeVM>(
          create: (BuildContext context) => SportsTabHomeVM(),
        ),
      ],
      child: const TabHomePage(),
    );
  }

  @override
  State createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController; //需要定义一个Controller
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {
      'title': '关注',
      'page': const SportsHomePage('关注'),
    },
    {
      'title': '推荐',
      'page': SportsHomeTvPage(),
    },
    {
      'title': '视频',
      'page': SportsHomeVideoPage(),
    },
    {
      'title': '热榜',
      'page': const SportsHomePage('热榜'),
    },
    {
      'title': '快讯',
      'page': const SportsHomePage('快讯'),
    },
    {
      'title': '中国足球',
      'page': const SportsHomePage('中国足球'),
    },
    {
      'title': '国际足球',
      'page': const SportsHomePage('国际足球'),
    }
  ];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SportsTabHomeVM vm = context.watch<SportsTabHomeVM>();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: vm.appBarBackgroundColor,
          brightness: Brightness.dark,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          // foregroundColor: Colors.white,
          // title: Text(widget.title),
          title: TabBar(
            //生成Tab菜单
            isScrollable: true,
            enableFeedback: false,
            overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Colors.transparent;
            }),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelStyle: const TextStyle(fontSize: 14),
            labelStyle: const TextStyle(fontSize: 16),
            controller: _tabController,
            tabs: _tabs.map((e) => Tab(text: e['title'].toString())).toList(),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                size: 22,
                color: Colors.white,
              ),
              onPressed: () {
                print("我是按钮");
              },
            ),
          ],
        ),
        body: ParentPageLifecycleWrapper(
          controller: _tabController,
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((e) {
              //创建3个Tab页
              return ChildPageLifecycleWrapper(
                index: _tabs.indexOf(e),
                child: e['page'] as Widget,
                // onLifecycleEvent: (LifecycleEvent event) {
                //   if (event == LifecycleEvent.active) {
                //     setState(() {});
                //   }
                //   print('Page@0#${event.toString()}');
                // },
              );
            }).toList(),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  bool get wantKeepAlive => true;
}
