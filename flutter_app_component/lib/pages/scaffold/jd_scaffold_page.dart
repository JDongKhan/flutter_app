import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/models/models.dart';
import 'package:flutter_app_component/pages/buiness/jd_business_page.dart';
import 'package:flutter_app_component/pages/discover/jd_discover_page.dart';
import 'package:flutter_app_component/pages/leftdrawer/jd_left_drawer.dart';
import 'package:flutter_app_component/pages/my/jd_my_page.dart';
import 'package:flutter_app_component/service/jd_request.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:jd_core/utils/jd_screen_utils.dart';
import 'package:jd_home/pages/home/jd_home_page.dart';

/**
 *
 * @author jd
 *
 */

class JDScaffoldPage extends StatefulWidget {
  @override
  State createState() => JDScaffoldPageState();

  static JDScaffoldPageState of(BuildContext context) {
    return context.findAncestorStateOfType<JDScaffoldPageState>();
  }
}

class JDScaffoldPageState extends State<JDScaffoldPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _tabs = List<Map<String, dynamic>>();
  int _selectedIndex = 0;

  TabController _tabController;

  final JDDrawer _drawer = JDDrawer();

  @override
  void initState() {
    super.initState();
    //初始化工具
    //initScreenUtil(context);
    _tabs.add({'title': '首页', 'icon': Icons.home, 'page': JDHomePage()});

    _tabs.add({
      'title': '业务',
      'icon': Icons.business,
      'page': JDBusinessPage('subhome')
    });

    _tabs.add({'title': '发现', 'icon': Icons.camera, 'page': JDDiscoverPage()});

    _tabs
        .add({'title': '我的', 'icon': Icons.account_circle, 'page': JDMyPage()});

    _tabController = TabController(length: _tabs.length, vsync: this);

//    AppUpgrade.appUpgrade(
//        context,
//        _checkAppInfo(),
//        okBackgroundColors: [Color(0xFF5DC782), Color(0xFF5DC782)],
//        progressBarColor: Color(0xFF5DC782).withOpacity(.5)
//    );
  }

  ///
  /// 检测app升级
  ///
  Future<AppUpgradeInfo> _checkAppInfo() async {
    final VersionModel updateInfo = await JDRequest.getUpgradeInfo();
    final AppInfo appInfo = await FlutterUpgrade.appInfo;
    if (updateInfo.version != appInfo.versionName) {
      return AppUpgradeInfo(
        title: updateInfo.title,
        contents: (updateInfo.content).split('\r\n'),
        apkDownloadUrl: updateInfo.url,
        force: updateInfo.force,
      );
    }
    return null;
  }

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  void switchTabbarIndex(int selectedIndex) {
    _tabController.index = selectedIndex;
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('你确定退出吗？'),
          actions: <Widget>[
            RaisedButton(
              child: const Text('退出'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            RaisedButton(
              child: const Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            )
          ],
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _drawer, //抽屉
        body: TabBarView(
//          index: _selectedIndex,
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
      ),
    );
  }

  void _onItemTapped(int index) {
    switchTabbarIndex(index);
  }
}
