import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/component/logger/logger_console_on_shake.dart';
import 'package:flutter_app_component/component/privacy_widget.dart';
import 'package:flutter_app_component/component/web/web_page.dart';
import 'package:flutter_app_component/models/models.dart';
import 'package:flutter_app_component/pages/leftdrawer/jd_left_drawer.dart';
import 'package:flutter_app_component/service/request.dart';
import 'package:flutter_app_component/utils/logger_util.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';

import 'scaffold_controller.dart';

/**
 *
 * @author jd
 *
 */

class ScaffoldPage extends StatefulWidget {
  @override
  State createState() => ScaffoldPageState();

  static ScaffoldPageState of(BuildContext context) {
    return context.findAncestorStateOfType<ScaffoldPageState>();
  }
}

class ScaffoldPageState extends State<ScaffoldPage>
    with SingleTickerProviderStateMixin {
  ///设置globalKey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///controller
  final ScaffoldController _controller = ScaffoldController();

  ///tabcontroller
  TabController _tabController;

  ///左侧菜单
  final JDDrawer _drawer = JDDrawer();

  @override
  void initState() {
    super.initState();

    ///日志
    logger.d('init pages');

    ///初始化数据
    _controller.initState();
    _controller.addListener(() {
      setState(() {});
    });

    ///初始化tab controller
    _tabController =
        TabController(length: _controller.tabs.length, vsync: this);

//    AppUpgrade.appUpgrade(
//        context,
//        _checkAppInfo(),
//        okBackgroundColors: [Color(0xFF5DC782), Color(0xFF5DC782)],
//        progressBarColor: Color(0xFF5DC782).withOpacity(.5)
//    );

    ///合适时机进行隐私弹框
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _showPrivacyView();
    });
  }

  /// 检测app升级
  Future<AppUpgradeInfo> _checkAppInfo() async {
    final VersionModel updateInfo = await Request.getUpgradeInfo();
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

  ///打开左侧菜单
  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  ///切换底部导航
  void switchTabbarIndex(int selectedIndex) {
    _tabController.index = selectedIndex;
    setState(() {
      _controller.selectedIndex = selectedIndex;
    });
  }

  ///隐藏底部导航
  void hiddenBottomNavigationBar(bool hidden) {
    setState(() {
      _controller.hiddenBottomBar = hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('你确定退出吗？'),
          actions: <Widget>[
            TextButton(
              child: const Text('退出'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: const Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            )
          ],
        ),
      ),
      child: LogConsoleOnShake(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: _drawer, //抽屉
          body: TabBarView(
//          index: _selectedIndex,
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: _controller.tabs.map((e) {
              return e['page'] as Widget;
            }).toList(),
          ),
          bottomNavigationBar:
              _controller.hiddenBottomBar ? null : _bottomBar(),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return BottomNavigationBar(
      // 底部导航
      items: _controller.tabs
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e["icon"] as IconData),
              label: e["title"].toString(),
            ),
          )
          .toList(),
      currentIndex: _controller.selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.red,
      onTap: _onItemTapped,
    );
  }

  ///点击底部item
  void _onItemTapped(int index) {
    switchTabbarIndex(index);
  }

  ///显示隐私弹框  来源：copy外部
  void _showPrivacyView() {
    String _data = "亲爱的xxxx用户，感谢您信任并使用xxxxAPP！\n" +
        " \n" +
        "xxxx十分重视用户权利及隐私政策并严格按照相关法律法规的要求，对《用户协议》和《隐私政策》进行了更新,特向您说明如下：\n" +
        "1.为向您提供更优质的服务，我们会收集、使用必要的信息，并会采取业界先进的安全措施保护您的信息安全；\n" +
        "2.基于您的明示授权，我们可能会获取设备号信息、包括：设备型号、操作系统版本、设备设置、设备标识符、MAC（媒体访问控制）地址、IMEI（移动设备国际身份码）、广告标识符（“IDFA”与“IDFV”）、集成电路卡识别码（“ICCD”）、软件安装列表。我们将使用三方产品（友盟、极光等）统计使用我们产品的设备数量并进行设备机型数据分析与设备适配性分析。（以保障您的账号与交易安全），且您有权拒绝或取消授权；\n" +
        "3.您可灵活设置伴伴账号的功能内容和互动权限，您可在《隐私政策》中了解到权限的详细应用说明；\n" +
        "4.未经您同意，我们不会从第三方获取、共享或向其提供您的信息；\n" +
        "5.您可以查询、更正、删除您的个人信息，我们也提供账户注销的渠道。\n" +
        " \n" +
        "请您仔细阅读并充分理解相关条款，其中重点条款已为您黑体加粗标识，方便您了解自己的权利。如您点击“同意”，即表示您已仔细阅读并同意本《用户协议》及《隐私政策》，将尽全力保障您的合法权益并继续为您提供优质的产品和服务。如您点击“不同意”，将可能导致您无法继续使用我们的产品和服务。";

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: const Text(
                      '用户隐私政策概要',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: PrivacyWidget(
                        data: _data,
                        keys: [
                          '《用户协议》',
                          '《隐私政策》',
                        ],
                        keyStyle: const TextStyle(color: Colors.red),
                        onTapCallback: (String key) {
                          if (key == '《用户协议》') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return WebPage(
                                      title: key, url: 'https://flutter.dev');
                                },
                              ),
                            );
                          } else if (key == '《隐私政策》') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return WebPage(
                                      title: key, url: 'https://www.baidu.com');
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('不同意'),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )),
                        const VerticalDivider(
                          width: 1,
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              color: Theme.of(context).primaryColor,
                              child: const Text('同意'),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
