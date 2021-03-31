import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/car/jd_shop_car_page.dart';
import 'package:flutter_app_component/demo/shop/category/jd_shop_category_page.dart';
import 'package:flutter_app_component/demo/shop/home/jd_shop_home_page.dart';
import 'package:flutter_app_component/demo/shop/my/jd_shop_my_page.dart';

/// @author jd

class JDShopMainPage extends StatefulWidget {
  @override
  _JDShopMainPageState createState() => _JDShopMainPageState();
}

class _JDShopMainPageState extends State<JDShopMainPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[];
  TabController _tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    //初始化工具
    //initScreenUtil(context);
    _tabs.add({
      'title': '首页',
      'icon': Icons.home,
      'page': JDShopHomePage(),
    });

    _tabs.add({
      'title': '分类',
      'icon': Icons.business,
      'page': JDShopCategoryPage(),
    });

    _tabs.add({
      'title': '购物车',
      'icon': Icons.camera,
      'page': JDShopCarPage(),
    });

    _tabs.add({
      'title': '我的',
      'icon': Icons.account_circle,
      'page': JDShopMyPage(),
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
            .map((e) => BottomNavigationBarItem(
                icon: Icon(e["icon"] as IconData),
                title: Text(e["title"].toString())))
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
