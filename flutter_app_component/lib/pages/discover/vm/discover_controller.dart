import 'package:flutter_app_component/component/input/pin_input_widget.dart';
import 'package:flutter_app_component/component/input/vercode_input_widget.dart';
import 'package:flutter_app_component/component/mask/bubble_demo_page.dart';
import 'package:flutter_app_component/demo/animal/anim_bg_demo_page.dart';
import 'package:flutter_app_component/demo/animal/anim_button/anim_button_demo_page.dart';
import 'package:flutter_app_component/demo/animal/animal_1.dart';
import 'package:flutter_app_component/demo/animal/animal_2.dart';
import 'package:flutter_app_component/demo/animal/animal_3.dart';
import 'package:flutter_app_component/demo/animal/particle/particle_page.dart';
import 'package:flutter_app_component/demo/animal/run_balls.dart';
import 'package:flutter_app_component/demo/bottom_drag_widget/bottom_drag_demo.dart';
import 'package:flutter_app_component/demo/bottom_sheet/bottom_anim_nav_page.dart';
import 'package:flutter_app_component/demo/canvas/clock/canvas_click_demo_page.dart';
import 'package:flutter_app_component/demo/canvas/clock_demo_page.dart';
import 'package:flutter_app_component/demo/canvas/halo/circle_halo.dart';
import 'package:flutter_app_component/demo/canvas/paragraph/paragraph_page.dart';
import 'package:flutter_app_component/demo/canvas/pie/ace_pie_page.dart';
import 'package:flutter_app_component/demo/canvas/progress/ace_progress_page.dart';
import 'package:flutter_app_component/demo/canvas/progress/circle_progress_demo_page.dart';
import 'package:flutter_app_component/demo/canvas/timeline_page.dart';
import 'package:flutter_app_component/demo/component/dialog/dialog_page.dart';
import 'package:flutter_app_component/demo/component/draggable/draggable_grid_page.dart';
import 'package:flutter_app_component/demo/component/draggable/draggable_scrollablesheet.dart';
import 'package:flutter_app_component/demo/component/pageview/pageview_page.dart';
import 'package:flutter_app_component/demo/component/reorderableListView/reorderable_list_view_page.dart';
import 'package:flutter_app_component/demo/component/textfield/textfield_page.dart';
import 'package:flutter_app_component/demo/component/timepicker/timepicker_page.dart';
import 'package:flutter_app_component/demo/custome_layout/customPainter/jd_custompainter.dart';
import 'package:flutter_app_component/demo/custome_layout/renderbox/cloud/cloud_demo_page.dart';
import 'package:flutter_app_component/demo/custome_layout/renderbox/jd_renderbox_demo.dart';
import 'package:flutter_app_component/demo/dash/dash_demo.dart';
import 'package:flutter_app_component/demo/databtransfer/event_bus/event_bus_page.dart';
import 'package:flutter_app_component/demo/databtransfer/get/get_demo_list_page.dart';
import 'package:flutter_app_component/demo/databtransfer/inherited_widget_page.dart';
import 'package:flutter_app_component/demo/databtransfer/notification_page.dart';
import 'package:flutter_app_component/demo/databtransfer/stream_page.dart';
import 'package:flutter_app_component/demo/didi/didi_main_page.dart';
import 'package:flutter_app_component/demo/douyin/home/page/douyin_home_page.dart';
import 'package:flutter_app_component/demo/dropmenu/drop_select_menu/drop_select_demo_page.dart';
import 'package:flutter_app_component/demo/dropmenu/jd_dropmenu_demo_page.dart';
import 'package:flutter_app_component/demo/funcation/state/tapbox_a_page.dart';
import 'package:flutter_app_component/demo/funcation/state/tapbox_b_page.dart';
import 'package:flutter_app_component/demo/funcation/state/tapbox_c_page.dart';
import 'package:flutter_app_component/demo/isolate/isolate_page.dart';
import 'package:flutter_app_component/demo/lifecycle/lifecycle_page.dart';
import 'package:flutter_app_component/demo/login/login_demo_list_page.dart';
import 'package:flutter_app_component/demo/pop/pop_demo_page.dart';
import 'package:flutter_app_component/demo/qq/anim_progressImg_demo_page.dart';
import 'package:flutter_app_component/demo/scroll/scroll_page.dart';
import 'package:flutter_app_component/demo/shop/car/car_1/page/shop_car_page.dart';
import 'package:flutter_app_component/demo/shop/shop_main_page.dart';
import 'package:flutter_app_component/demo/sports/live/sports_live_detail_page.dart';
import 'package:flutter_app_component/demo/stick/stick_demo_page.dart';
import 'package:flutter_app_component/demo/stick/stick_demo_page2.dart';
import 'package:flutter_app_component/demo/tantan/anim_scan_demo_page.dart';
import 'package:flutter_app_component/demo/wechat/discover/friend_circle/page/wechat_friend_circle_page.dart';
import 'package:flutter_app_component/demo/wechat/wechat_main_page.dart';
import 'package:jd_core/view_model/single_view_model.dart';

import '../page/discover_page.dart';

/// @author jd

class DiscoverController extends SingleViewModel {
  int currentIndex = 0;

  ///用map代替model
  final List<Map<String, dynamic>> moduleList = <Map<String, dynamic>>[
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
          'page': () => ShopMainPage(),
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
          'title': 'BottomSheet',
          'page': BottomAnimNavPage(),
        },
        {
          'title': '第三方组件',
          'router': '/thirdparty_list',
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
          'title': 'DropdownMenuDemoPage',
          'page': JDDropdownMenuDemoPage(),
        },
        {
          'title': 'DropdownMenuDemoPage2',
          'page': DropSelectDemoPage(),
        },
        {
          'title': 'PopDemoPage',
          'page': PopDemoPage(),
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
          'page': LifeCyclePage(),
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
        {
          'title': 'TimePicker',
          'page': TimePickerPage(),
        },
        {
          'title': 'Dialog',
          'page': DialogPage(),
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
          'page': ReorderableListViewPage(),
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
          'page': Animal1(),
        },
        {
          'title': 'Animal 2',
          'page': Animal2(),
        },
        {
          'title': 'Animal 3',
          'page': Animal3(),
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
        },
        {
          'title': 'CircleProgressDemoPage',
          'page': CircleProgressDemoPage(),
        }
      ],
    },

    ///State
    {
      'title': 'State',
      'items': [
        {
          'title': '状态1',
          'page': TapboxAPage(),
        },
        {
          'title': '状态2',
          'page': ParentWidgetBPage(),
        },
        {
          'title': '状态3',
          'page': ParentWidgetCPage(),
        }
      ],
    },

    ///DataTransfer
    {
      'title': 'DataTransfer',
      'items': [
        {
          'title': 'InheritedWidget',
          'page': InheritedWdgetPage(),
        },
        {
          'title': 'Notification',
          'page': NotificationPage(),
        },
        {
          'title': 'EventBus',
          'page': EventBusPage(),
        },
        {
          'title': 'Stream',
          'page': StreamPage(),
        },
        {
          'title': 'Get Demo List',
          'page': GetDemoListPage(),
        },
      ],
    },

    ///My的组件
    {
      'title': '我的组件',
      'items': [
        {
          'title': 'BottomDragDemo',
          'page': BottomDragDemo(),
        },
        {
          'title': 'DropdownMenuDemoPage',
          'page': JDDropdownMenuDemoPage(),
        },
        {
          'title': 'InputMessageWidget',
          'page': DouYinHomePage(),
        },
        {
          'title': '蒙版提示',
          'page': DiscoverPage(),
        },
        {
          'title': 'Number Widget',
          'page': ShopCarPage(),
        },
        {
          'title': 'Pop 横向菜单',
          'page': WechatFriendCirclePage(),
        },
        {
          'title': 'AutoCompleteTextField',
          'page': TextFieldPage(),
        },
        {
          'title': '拖动进度条',
          'page': SportsLiveDetailPage(),
        },
      ],
    },
  ];

  @override
  Future loadData() async {
    return true;
  }

  @override
  void onCompleted(data) {}
}
