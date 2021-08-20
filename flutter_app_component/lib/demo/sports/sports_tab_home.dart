import 'package:flutter/material.dart';

import 'home/page/sports_home_page.dart';
import 'home/page/sports_home_video_page.dart';

/**
 *
 * @author jd
 *
 */

class TabHomePage extends StatefulWidget {
  final String title = "jd_tab_home";

  @override
  State createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController; //需要定义一个Controller
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {
      'title': '关注',
      'page': SportsHomePage('关注'),
    },
    {
      'title': '推荐',
      'page': SportsHomePage('推荐'),
    },
    {
      'title': '视频',
      'page': SportsHomeVideoPage(),
    },
    {
      'title': '热榜',
      'page': SportsHomePage('热榜'),
    },
    {
      'title': '快讯',
      'page': SportsHomePage('快讯'),
    },
    {
      'title': '中国足球',
      'page': SportsHomePage('中国足球'),
    },
    {
      'title': '国际足球',
      'page': SportsHomePage('国际足球'),
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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Colors.blue,
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
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((e) {
            //创建3个Tab页
            return e['page'] as Widget;
          }).toList(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  bool get wantKeepAlive => true;
}
