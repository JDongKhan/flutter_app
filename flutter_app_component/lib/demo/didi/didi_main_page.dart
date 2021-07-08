import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home/didi_home_page.dart';

/// @author jd

/// @author jd

class DidiMainPage extends StatefulWidget {
  @override
  _DidiMainPageState createState() => _DidiMainPageState();
}

class _DidiMainPageState extends State<DidiMainPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = [];
  TabController _tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    _tabs.add({
      'title': '滴滴',
      'icon': Icons.home,
      'page': DidiHomePage(),
    });

    _tabs.add({
      'title': '优选',
      'icon': Icons.business,
      'page': DidiHomePage(),
    });

    _tabs.add({
      'title': '领现金',
      'icon': Icons.camera,
      'page': DidiHomePage(),
    });

    _tabs.add({
      'title': '我的',
      'icon': Icons.account_circle,
      'page': DidiHomePage(),
    });

    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
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
      bottomNavigationBar: BottomNavigationBar(
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
      ),
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
