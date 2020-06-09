import 'package:flutter/material.dart';

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

class _JDTabHomePageState extends State<JDTabHomePage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  TabController _tabController; //需要定义一个Controller

  List<String> tabs = <String>["新闻", "历史", "图片"];

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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(   //生成Tab菜单
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList()
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) { //创建3个Tab页
            return Container(
              alignment: Alignment.center,
              child: Text(e, textScaleFactor: 5),
            );
          }).toList(),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;
}