import 'package:flutter/material.dart';
import 'package:flutter_app_component/debug/environment/environment_page.dart';
import 'package:flutter_app_component/pages/setting/developer/developer_setting_page.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import 'logger/log_console.dart';

/// @author jd

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List _menuList = [
    {
      'title': '环境配置',
      'click': () => JDNavigationUtil.push(EnvironmentPage()),
    },
    {
      'title': '日志',
      'click': () => JDNavigationUtil.push(LogConsole(
            showCloseButton: true,
          )),
    },
    {
      'title': '开发者设置',
      'click': () => JDNavigationUtil.push(DeveloperSettingPage()),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text('Debug 菜单'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          Map e = _menuList[index];
          return ListTile(
            title: Text(e['title'].toString()),
            onTap: () {
              _onClick(e['click'] as Function);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: _menuList.length,
      ),
    );
  }

  void _onClick(Function click) {
    if (click != null) {
      click();
    }
  }
}
