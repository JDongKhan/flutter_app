import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';

import 'city/page/douyin_friend_page.dart';
import 'home/page/douyin_home_page.dart';

/// @author jd

class DouyinMainPage extends StatefulWidget {
  @override
  _DouyinMainPageState createState() => _DouyinMainPageState();
}

class _DouyinMainPageState extends State<DouyinMainPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[];
  TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    //初始化工具
    //initScreenUtil(context);
    _tabs.add({'title': '首页', 'icon': Icons.home, 'page': DouYinHomePage()});

    _tabs.add({
      'title': '朋友',
      'icon': Icons.child_friendly,
      'page': DouyinFriendPage(),
    });

    _tabs.add({
      'title': '消息',
      'icon': Icons.camera,
      'page': Container(
        color: Colors.green,
      )
    });

    _tabs.add({
      'title': '我的',
      'icon': Icons.account_circle,
      'page': Container(
        color: Colors.greenAccent,
      )
    });

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTabBarView(),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[100],
        mini: true,
        //悬浮按钮
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _buildTabBarView() {
    return ParentPageLifecycleWrapper(
      controller: _tabController,
      child: TabBarView(
//          index: _selectedIndex,
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: _tabs.map((e) {
          return ChildPageLifecycleWrapper(
            index: _tabs.indexOf(e),
            child: e['page'] as Widget,
          );
        }).toList(),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      // 底部导航
      items: _tabs
          .map(
            (Map<String, dynamic> e) => BottomNavigationBarItem(
              icon: Icon(
                e['icon'] as IconData,
              ),
              label: e['title'].toString(),
            ),
          )
          .toList(),
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[350],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    switchTabbarIndex(index);
  }

  void switchTabbarIndex(int selectedIndex) {
    _tabController.index = selectedIndex;
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }
}
