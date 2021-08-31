import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/component/tabbar_life_cycle/tabbar_life_cycle.dart';

import 'douyin_home_cicy_page.dart';
import 'douyin_home_focus_page.dart';
import 'douyin_home_recommend_page.dart';

/// @author jd
/// 首页

class DouYinHomePage extends StatefulWidget {
  @override
  _DouYinHomePageState createState() => _DouYinHomePageState();
}

class _DouYinHomePageState extends State<DouYinHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': '同城',
      'page': DouyinHomeCityPage(),
    },
    {
      'title': '关注',
      'page': DouyinHomeoFocusPage(),
    },
    {
      'title': '推荐',
      'page': const DouyinHomeRecommendPage(
        source: 'home',
      ),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildBackground(),
            _buildContentPage(),
            _buildTopMenu(),
          ],
        ),
      ),
    );
  }

  /******  背景 ********/
  Widget _buildBackground() {
    return Container(
      color: Colors.black,
    );
  }

  @override
  void deactivate() {
    debugPrint('deactivate');
    super.deactivate();
  }
  /******  顶部菜单 ********/

  Widget _buildTopMenu() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 80,
                child: IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
              _buildTabbar(),
              Container(
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabbar() {
    return Container(
      width: 200,
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        tabs: _tabs
            .map((e) => Tab(
                  child: Text(
                    e['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildContentPage() {
    return TabbarViewLifeCycle(
      tabController: _tabController,
      child: TabBarView(
        controller: _tabController,
        children: _tabs
            .map((e) => TabbarItemLifecycle(
                  index: _tabs.indexOf(e),
                  child: e['page'] as Widget,
                ))
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
