import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/car/car_1/page/shop_car_page.dart';
import 'package:flutter_app_component/demo/shop/category/shop_category_page.dart';
import 'package:flutter_app_component/demo/shop/home/page/shop_home_page.dart';
import 'package:flutter_app_component/demo/shop/my/page/shop_my_page.dart';

/// @author jd

class ShopMainPage extends StatefulWidget {
  static _ShopMainPageState of(BuildContext context) {
    return context.findAncestorStateOfType<_ShopMainPageState>();
  }

  @override
  _ShopMainPageState createState() => _ShopMainPageState();
}

class _ShopMainPageState extends State<ShopMainPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[];
  TabController _tabController;
  int _selectedIndex = 0;
  bool _hiddenBottomBar = false;
  @override
  void initState() {
    //初始化工具
    //initScreenUtil(context);
    _tabs.add({
      'title': '首页',
      'icon': Icons.home,
      'page': ShopHomePage(),
    });

    _tabs.add({
      'title': '分类',
      'icon': Icons.business,
      'page': ShopCategoryPage(),
    });

    _tabs.add({
      'title': '购物车',
      'icon': Icons.camera,
      'page': ShopCarPage(),
    });

    _tabs.add({
      'title': '我的',
      'icon': Icons.account_circle,
      'page': ShopMyPage(),
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
      bottomNavigationBar: _hiddenBottomBar
          ? null
          : BottomNavigationBar(
              // 底部导航
              items: _tabs
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: Icon(e['icon'] as IconData),
                      label: e['title'].toString(),
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
