import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'discover/wechat_discover_page.dart';
import 'mail_list/wechat_mail_list_page.dart';
import 'message_list/message_list/wechat_message_list_page.dart';
import 'mine/wechat_mine_page.dart';

/// @author jd

class WechatMainPage extends StatefulWidget {
  @override
  _WechatMainPageState createState() => _WechatMainPageState();

  static _WechatMainPageState of(BuildContext context) {
    return context.findAncestorStateOfType<_WechatMainPageState>();
  }
}

class _WechatMainPageState extends State<WechatMainPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = [];
  TabController _tabController;
  int _selectedIndex = 0;
  bool _hiddenBottomBar = false;
  @override
  void initState() {
    _tabs.add({
      'title': '微信',
      'icon': Icons.home,
      'page': WechatMessageListPage(),
    });

    _tabs.add({
      'title': '通讯录',
      'icon': Icons.business,
      'page': WechatMailListPage(),
    });

    _tabs.add({
      'title': '发现',
      'icon': Icons.camera,
      'page': WechatDiscoverPage(),
    });

    _tabs.add({
      'title': '我',
      'icon': Icons.account_circle,
      'page': WechatMinePage(),
    });

    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  void hiddenBottomNavigationBar(bool hidden) {
    setState(() {
      _hiddenBottomBar = hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: _tabs.map((e) {
          return e['page'] as Widget;
        }).toList(),
      ),
      bottomNavigationBar: _hiddenBottomBar ? null : _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      // 底部导航
      items: _tabs
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e["icon"] as IconData),
              label: e["title"].toString(),
            ),
          )
          .toList(),
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.red,
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
