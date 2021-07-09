import 'package:flutter/material.dart';

import 'home/jd_sports_tab_home_firstpage.dart';

/**
 *
 * @author jd
 *
 */

class JDTabHomePage extends StatefulWidget {
  final String title = "jd_tab_home";

  @override
  State createState() => _JDTabHomePageState();
}

class _JDTabHomePageState extends State<JDTabHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController; //需要定义一个Controller

  List<String> tabs = <String>["关注", "推荐", "视频", "热榜", "快讯", "中国足球", "国际足球"];

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
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
          elevation: 1,
          backgroundColor: Colors.black87,
          brightness: Brightness.dark,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          // foregroundColor: Colors.white,
          // title: Text(widget.title),
          title: TabBar(
            //生成Tab菜单
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.white,
            unselectedLabelStyle: TextStyle(fontSize: 14),
            labelStyle: TextStyle(fontSize: 18),
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
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
          children: tabs.map((e) {
            //创建3个Tab页
            return JDTabHomeFirstPage(e);
          }).toList(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  bool get wantKeepAlive => true;
}
