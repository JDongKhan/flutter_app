import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/bottom_drag_widget/bottom_drag_demo.dart';
import 'package:flutter_app_component/demo/component/customPainter/jd_custompainter.dart';
import 'package:flutter_app_component/demo/component/reorderableListView/reorderableListView.dart';
import 'package:flutter_app_component/demo/dash/dash_demo.dart';
import 'package:flutter_app_component/demo/dropmenu/jd_dropmenu_demo_page.dart';
import 'package:flutter_app_component/demo/fishredux/OnePage/page.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_tapbox_a.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_tapbox_b.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_tapbox_c.dart';
import 'package:flutter_app_component/demo/link_scroll_menu/jd_link_scroll_menu.dart';
import 'package:flutter_app_component/demo/pop/jd_pop_demo_page.dart';
import 'package:flutter_app_component/demo/renderbox/jd_renderbox_demo.dart';
import 'package:flutter_app_component/demo/shop/jd_shop_main_page.dart';
import 'package:flutter_app_component/pages/scaffold/jd_scaffold_page.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/utils/jd_share_utils.dart';

class JDDiscoverPage extends StatefulWidget {
  @override
  State createState() => _JDDiscoverPageState();
}

class _JDDiscoverPageState extends State<JDDiscoverPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> module_list = <Map<String, dynamic>>[
    {
      'title': '组件列表',
      'items': [
        //基础组件
        {
          'title': 'Text',
          'router': '/text',
        },
        {
          'title': 'Button',
          'router': '/button',
        },
        {
          'title': 'Image',
          'router': '/image',
        },
        {
          'title': 'CheckBox',
          'router': '/checkbox',
        },
        {
          'title': 'TextField',
          'router': '/textfield',
        },
        {
          'title': 'LinearProgressIndicator',
          'router': '/linearprogressindicator',
        },

        //布局组件
        {
          'title': 'RowColumn',
          'router': '/rowcolumn',
        },
        {
          'title': 'Flex',
          'router': '/flex',
        },
        {
          'title': 'WrapFlow',
          'router': '/wrapflow',
        },
        {
          'title': 'Flow',
          'router': '/flow',
        },
        {
          'title': 'StackPositioned',
          'router': '/stackpositioned',
        },
        {
          'title': 'Align',
          'router': '/align',
        },
        {
          'title': 'Expanded',
          'router': '/expanded',
        },

        //容器组件
        {
          'title': 'Padding',
          'router': '/padding',
        },
        {
          'title': 'ConstrainedBox',
          'router': '/constrainedbox',
        },
        {
          'title': 'DecoratedBox',
          'router': '/decoratedbox',
        },
        {
          'title': 'TransformPage',
          'router': '/transform',
        },
        {
          'title': 'Container',
          'router': '/container',
        },

        //滚动组件
        {
          'title': 'SingleChildScrollView',
          'router': '/singlechildscrollview',
        },
        {
          'title': 'ListView',
          'router': '/listview',
        },
        {
          'title': 'GridView',
          'router': '/gridview',
        },
        {
          'title': 'CustomScrollView',
          'router': '/customscrollview',
        },
        {
          'title': 'NestedScrollView',
          'router': '/nestedscrollview_list',
        },
        {
          'title': 'Tabbar',
          'router': '/tabbar_component',
        },
        {
          'title': 'CustomPainter',
          'page': JDCircleProgressPage(),
        },
        {
          'title': 'ReorderableListView',
          'page': JDReorderableListView(),
        }
      ],
    },
    {
      'title': 'State',
      'items': [
        {
          'title': '状态1',
          'page': JDTapboxA(),
        },
        {
          'title': '状态2',
          'page': JDParentWidgetB(),
        },
        {
          'title': '状态3',
          'page': JDParentWidgetC(),
        }
      ],
    },
    {
      'title': 'DataTransfer',
      'items': [
        {
          'title': 'InheritedWidget',
          'router': '/inheritedwidget',
        },
        {
          'title': 'Notification',
          'router': '/notification',
        },
        {
          'title': 'EventBus',
          'router': '/eventbus',
        },
        {
          'title': 'Stream',
          'router': '/stream',
        }
      ],
    },
    {
      'title': 'Demo',
      'items': [
        {
          'title': 'Login',
          'router': '/login',
        },
        {
          'title': 'Scaffold',
          'router': '/scaffold',
        },
        {
          'title': 'Tabbar',
          'router': '/tabbar',
        },
        {
          'title': '抖音',
          'router': '/douyin',
        },
        {
          'title': '商城',
          'page': JDShopMainPage(),
        },
        {
          'title': '购物车',
          'router': '/buy_car',
        },
        {
          'title': '拍照',
          'router': '/pickImage',
        },
        {
          'title': '第三方组件',
          'router': '/thirdparty_list',
        },
        {
          'title': 'fishredux',
          'page': OnePagePage().buildPage({}),
        },
        {
          'title': 'BottomDragDemo',
          'page': BottomDragDemo(),
        },
        {
          'title': 'LinkScrollMenu',
          'page': JDLinkScrollMenu(),
        },
        {
          'title': 'RenderBoxDemo',
          'page': JDRenderShiftedBoxDemo(),
        },
        {
          'title': 'DropdownMenuDemoPage',
          'page': JDDropdownMenuDemoPage(),
        },
        {
          'title': 'PopDemoPage',
          'page': JDPopDemoPage(),
        },
        {
          'title': 'DashDemo',
          'page': DashDemo(),
        }
      ],
    }
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildLeftMenu() {
    //下划线widget预定义以供复用。
    final Widget divider1 = Divider(
      height: 1,
      color: Colors.blue,
    );
    return Container(
      width: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: module_list.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(module_list[i], i);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return divider1;
        },
      ),
    );
  }

  Widget _buildRightMenu() {
    Map map = module_list[_currentIndex];
    List currentList = map['items'];
    return Container(
      color: Colors.grey[100],
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: currentList?.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          Map item = currentList[i];
          String text = item['title'];
          return InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            onTap: () {
              _pushSaved(text, item['router'], item['page']);
            },
          );
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.blue,
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return Row(
      children: <Widget>[
        _buildLeftMenu(),
        Expanded(
          child: _buildRightMenu(),
        ),
      ],
    );
  }

  Widget _buildRow(Map<String, dynamic> map, int index) {
    final String text = map['title'];
    return InkWell(
      child: Container(
        color: index == _currentIndex ? Colors.grey[100] : Colors.white,
        alignment: Alignment.centerLeft,
        height: 40,
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14.0),
        ),
      ),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  void _pushSaved(String title, String router, Widget page) async {
    if (page != null) {
      JDNavigationUtil.push(page);
      return;
    }
    // Navigator.pushNamed(context, router);
    var map = JDNavigationUtil.pushNamed(router, arguments: {'title': title});
    //带有返回值
//    var map = await Navigator.of(context).pushNamed(router, arguments: {'title' : title});
    print(map);

//
//  //此种方法可传参
//    Navigator.of(context).push(
//      new CupertinoPageRoute(
//        builder: (context) {
//          return new NetworkPage();
//        },
//      ),
//    );

//    Navigator.of(context).pushNamed(router);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1, //隐藏底部阴影
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          '发现',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              JDScaffoldPage.of(context).switchTabbarIndex(0);
            }),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              showShareBottomSheet(context);
              return;
              final snackBar = SnackBar(
                content: const Text('我是提示文本'),
                backgroundColor: Colors.green,
                duration: const Duration(milliseconds: 5000),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: '取消',
                  onPressed: () {},
                ),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
            tooltip: '分享',
          ),
          //菜单按钮
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            onSelected: (String item) {
              if (item == 'download') {
                _download();
              } else {
                _share();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              //菜单项
              const PopupMenuItem<String>(
                value: 'friend',
                child: Text('分享到朋友圈'),
              ),
              const PopupMenuItem<String>(
                value: 'download',
                child: Text('下载到本地'),
              ),
            ],
          )
        ],
      ),
      body:
          _buildSuggestions(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _share() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: const Text('提示'),
            message: const Text('是否继续分享？'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: const Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  void _download() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {},
              ),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}