import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/input/pin_input_widget.dart';
import 'package:flutter_app_component/component/input/vercode_input_widget.dart';
import 'package:flutter_app_component/component/mask/bubble_demo_page.dart';
import 'package:flutter_app_component/component/mask/bubble_widget.dart';
import 'package:flutter_app_component/component/mask/mask_widget.dart';
import 'package:flutter_app_component/demo/animal/anim_bg_demo_page.dart';
import 'package:flutter_app_component/demo/animal/anim_button/anim_button_demo_page.dart';
import 'package:flutter_app_component/demo/animal/animal_1.dart';
import 'package:flutter_app_component/demo/animal/animal_2.dart';
import 'package:flutter_app_component/demo/animal/animal_3.dart';
import 'package:flutter_app_component/demo/animal/particle/particle_page.dart';
import 'package:flutter_app_component/demo/animal/run_balls.dart';
import 'package:flutter_app_component/demo/bookpage/book_page.dart';
import 'package:flutter_app_component/demo/bottom_drag_widget/bottom_drag_demo.dart';
import 'package:flutter_app_component/demo/bottom_sheet/bottom_anim_nav_page.dart';
import 'package:flutter_app_component/demo/canvas/clock/canvas_click_demo_page.dart';
import 'package:flutter_app_component/demo/canvas/clock_demo_page.dart';
import 'package:flutter_app_component/demo/canvas/halo/circle_halo.dart';
import 'package:flutter_app_component/demo/canvas/paragraph/paragraph_page.dart';
import 'package:flutter_app_component/demo/canvas/pie/ace_pie_page.dart';
import 'package:flutter_app_component/demo/canvas/progress/ace_progress_page.dart';
import 'package:flutter_app_component/demo/canvas/timeline_page.dart';
import 'package:flutter_app_component/demo/component/draggable/draggable_grid_page.dart';
import 'package:flutter_app_component/demo/component/draggable/draggable_scrollablesheet.dart';
import 'package:flutter_app_component/demo/component/pageview/pageview_page.dart';
import 'package:flutter_app_component/demo/component/reorderableListView/reorderableListView.dart';
import 'package:flutter_app_component/demo/custome_layout/customPainter/jd_custompainter.dart';
import 'package:flutter_app_component/demo/custome_layout/renderbox/cloud/cloud_demo_page.dart';
import 'package:flutter_app_component/demo/custome_layout/renderbox/jd_renderbox_demo.dart';
import 'package:flutter_app_component/demo/dash/dash_demo.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_event_bus.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_inherited_widget.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_notification.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_stream.dart';
import 'package:flutter_app_component/demo/didi/didi_main_page.dart';
import 'package:flutter_app_component/demo/dropmenu/drop_select_menu/drop_select_demo_page.dart';
import 'package:flutter_app_component/demo/dropmenu/jd_dropmenu_demo_page.dart';
import 'package:flutter_app_component/demo/fishredux/OnePage/page.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_tapbox_a.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_tapbox_b.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_tapbox_c.dart';
import 'package:flutter_app_component/demo/isolate/isolate_page.dart';
import 'package:flutter_app_component/demo/lifecycle/jd_lifecycle_page.dart';
import 'package:flutter_app_component/demo/link_scroll_menu/jd_link_scroll_menu.dart';
import 'package:flutter_app_component/demo/login/login_demo_list_page.dart';
import 'package:flutter_app_component/demo/pop/jd_pop_demo_page.dart';
import 'package:flutter_app_component/demo/qq/anim_progressImg_demo_page.dart';
import 'package:flutter_app_component/demo/scroll/scroll_page.dart';
import 'package:flutter_app_component/demo/shop/jd_shop_main_page.dart';
import 'package:flutter_app_component/demo/stick/stick_demo_page.dart';
import 'package:flutter_app_component/demo/stick/stick_demo_page2.dart';
import 'package:flutter_app_component/demo/tantan/anim_scan_demo_page.dart';
import 'package:flutter_app_component/demo/wechat/wechat_main_page.dart';
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
    ///demo
    {
      'title': 'Demo',
      'items': [
        {
          'title': '抖音',
          'router': '/douyin',
        },
        {
          'title': 'Wechat',
          'page': WechatMainPage(),
        },
        {
          'title': '商城',
          'page': JDShopMainPage(),
        },
        {
          'title': '滴滴',
          'page': DidiMainPage(),
        },
        {
          'title': 'PP体育',
          'router': '/tabbar',
        },
        {
          'title': 'Login',
          'page': LoginDemoListPage(),
        },
        {
          'title': 'Book',
          'page': BookPage(),
        },
        {
          'title': 'BottomSheet',
          'page': BottomAnimNavPage(),
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
          'title': '列表滑动停靠 （Stick）',
          'page': StickDemoPage(),
        },
        {
          'title': '列表滑动停靠 （Stick）+ 展开收回',
          'page': StickExpendDemoPage(),
        },
        {
          'title': 'Bubble',
          'page': BubbleDemoPage(),
        },
        {
          'title': '验证码输入框',
          'page': VerificationCodeInputDemoPage(),
        },
        {
          'title': '支付密码输入框',
          'page': VerificationCodeInputDemoPage2(),
        },
        {
          'title': '类似QQ发送图片的动画',
          'page': AnimProgressImgDemoPage(),
        },
        {
          'title': '类似探探扫描的动画效果',
          'page': AnimScanDemoPage(),
        },
        {
          'title': 'LinkScrollMenu',
          'page': JDLinkScrollMenu(),
        },
        {
          'title': 'DropdownMenuDemoPage',
          'page': JDDropdownMenuDemoPage(),
        },
        {
          'title': 'DropdownMenuDemoPage2',
          'page': DropSelectDemoPage(),
        },
        {
          'title': 'PopDemoPage',
          'page': JDPopDemoPage(),
        },
        {
          'title': 'DashDemo',
          'page': DashDemo(),
        },
        {
          'title': 'IsolatePage',
          'page': IsolatePage(),
        },
        {
          'title': 'SrcollPage',
          'page': SrcollPage(),
        },
        {
          'title': 'LifeCycle',
          'page': JDLifeCyclePage(),
        },
        {
          'title': 'Scaffold',
          'router': '/scaffold',
        },
      ],
    },

    ///widget
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
        {
          'title': 'PageViewPage',
          'page': PageViewPage(),
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
          'title': 'ReorderableListView',
          'page': JDReorderableListView(),
        },
        {
          'title': 'DraggableGridPage',
          'page': DraggableGridPage(),
        },
        {
          'title': 'DraggableScrollableSheet Page',
          'page': DraggableScrollableSheetPage(),
        }
      ],
    },
    //自定义布局
    {
      'title': '自定义布局',
      'items': [
        {
          'title': 'CustomSingleChildLayout/CustomMultiChildLayout',
          'page': JDCircleProgressPage(),
        },
        {
          'title': 'MultiChildRenderObjectWidget',
          'page': CloudDemoPage(),
        },
        {
          'title': 'SingleChildRenderObjectWidget',
          'page': JDRenderShiftedBoxDemo(),
        },
      ],
    },

    ///Animal
    {
      'title': 'Animal',
      'items': [
        {
          'title': 'Animal 1',
          'page': JDAnimal1(),
        },
        {
          'title': 'Animal 2',
          'page': JDAnimal2(),
        },
        {
          'title': 'Animal 3',
          'page': JDAnimal3(),
        },
        {
          'title': 'AnimButtonDemoPage',
          'page': AnimButtonDemoPage(),
        },
        {
          'title': 'AnimBgDemoPage',
          'page': AnimBgDemoPage(),
        },
        {
          'title': '粒子动画',
          'page': ParticlePage(),
        },
        {
          'title': 'RunBall',
          'page': RunBall(),
        }
      ],
    },

    ///Canvas
    {
      'title': 'Canvas',
      'items': [
        {
          'title': 'ClockDemoPage',
          'page': ClockDemoPage(),
        },
        {
          'title': 'CanvasClickDemoPage',
          'page': CanvasClickDemoPage(),
        },
        {
          'title': 'TimeLinePage',
          'page': TimeLinePage(),
        },
        {
          'title': 'PiePage',
          'page': ACEPiePage(),
        },
        {
          'title': 'ProgressPage',
          'page': ACEProgressPage(),
        },
        {
          'title': 'ParagraphPage',
          'page': ParagraphPage(),
        },
        {
          'title': 'CircleHalo',
          'page': CircleHalo(),
        }
      ],
    },

    ///State
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

    ///DataTransfer
    {
      'title': 'DataTransfer',
      'items': [
        {
          'title': 'InheritedWidget',
          'page': JDInheritedWdgetPage(),
        },
        {
          'title': 'Notification',
          'page': JDNotificationPage(),
        },
        {
          'title': 'EventBus',
          'page': JDEventBusPage(),
        },
        {
          'title': 'Stream',
          'page': JDStreamPage(),
        }
      ],
    },
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MarkUtils.showMark(context, [
        MarkEntry(
          widget: BubbleWidget(
            child: Text(
              '标题',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          left: 100,
          top: 80,
        ),
        MarkEntry(
          widget: BubbleWidget(
            position: BubbleArrowDirection.right,
            child: Text(
              '内容',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          left: 100,
          top: 100,
        ),
        MarkEntry(
          widget: BubbleWidget(
            position: BubbleArrowDirection.left,
            child: Text(
              '列表',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          left: 10,
          top: 200,
        ),
      ]);
    });
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
