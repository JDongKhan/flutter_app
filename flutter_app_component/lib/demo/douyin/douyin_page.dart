import 'package:flutter/material.dart';

import 'douyin_home_page.dart';

/// @author jd

class DouyinPage extends StatefulWidget {
  @override
  _DouyinPageState createState() => _DouyinPageState();
}

class _DouyinPageState extends State<DouyinPage>
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
      'title': '南京',
      'icon': Icons.business,
      'page': Container(
        color: Colors.blue,
      )
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
      body: Stack(
        children: <Widget>[
          _buildTabBarView(),
          Container(
            alignment: Alignment.bottomCenter,
            child: _bottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
//          index: _selectedIndex,
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: _tabs.map((e) {
        return e['page'] as Widget;
      }).toList(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      // 底部导航
      items: _tabs
          .map((Map<String, dynamic> e) => BottomNavigationBarItem(
              icon: Icon(
                e['icon'] as IconData,
              ),
              title: Text(
                e['title'].toString(),
              )))
          .toList(),
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
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
