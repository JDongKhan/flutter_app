import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/pages/buiness/business_page.dart';
import 'package:flutter_app_component/pages/discover/discover_page.dart';
import 'package:flutter_app_component/pages/my/my_page.dart';
import 'package:jd_home/pages/home_page.dart';

/// @author jd

class ScaffoldController extends ChangeNotifier {
  ///tabs
  final List<Map<String, dynamic>> tabs = <Map<String, dynamic>>[];

  ///当前选中
  int selectedIndex = 0;

  ///隐藏底部Bar
  bool hiddenBottomBar = false;

  void initState() {
    ///首页
    tabs.add({'title': '首页', 'icon': Icons.home, 'page': HomePage()});

    ///业务
    tabs.add({
      'title': '业务',
      'icon': Icons.business,
      'page': BusinessPage('subhome')
    });

    ///发现
    tabs.add({'title': '发现', 'icon': Icons.camera, 'page': DiscoverPage()});

    ///我的
    tabs.add({'title': '我的', 'icon': Icons.account_circle, 'page': MyPage()});
  }
}
