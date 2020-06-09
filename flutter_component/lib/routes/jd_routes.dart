import 'package:flutter/material.dart';
import 'package:flutter_component/demo/component/jd_component_list.dart';
import 'package:flutter_component/demo/component/expanded/jd_expanded.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview_list.dart';
import 'package:flutter_component/demo/component/text/jd_text.dart';
import 'package:flutter_component/demo/component/button/jd_button.dart';
import 'package:flutter_component/demo/component/image/jd_image.dart';
import 'package:flutter_component/demo/component/checkbox/jd_checkbox.dart';
import 'package:flutter_component/demo/component/textfield/jd_textfield.dart';
import 'package:flutter_component/demo/component/linearprogressindicator/jd_linearprogressindicator.dart';
import 'package:flutter_component/demo/component/gridview/jd_gridview.dart';
import 'package:flutter_component/demo/component/listview/jd_listview.dart';

import 'package:flutter_component/demo/component/container/jd_container.dart';
import 'package:flutter_component/demo/component/constrainedbox/jd_constrainedbox.dart';
import 'package:flutter_component/demo/component/customscrollview/jd_customscrollview.dart';
import 'package:flutter_component/demo/component/decoratedbox/jd_decoratedbox.dart';
import 'package:flutter_component/demo/component/flex/jd_flex.dart';
import 'package:flutter_component/demo/component/padding/jd_padding.dart';
import 'package:flutter_component/demo/component/row_column/jd_row_column.dart';
import 'package:flutter_component/demo/component/singlechildscrollView/jd_singlechildscrollView.dart';
import 'package:flutter_component/demo/component/stack_positioned/jd_stack_positioned.dart';
import 'package:flutter_component/demo/component/wrap_flow/jd_wrap_flow.dart';
import 'package:flutter_component/demo/component/transform/jd_transform.dart';
import 'package:flutter_component/demo/component/align/jd_align.dart';
import 'package:flutter_component/demo/databtransfer/jd_index.dart';
import 'package:flutter_component/demo/databtransfer/jd_inherited_widget.dart';
import 'package:flutter_component/demo/databtransfer/jd_event_bus.dart';
import 'package:flutter_component/demo/databtransfer/jd_stream.dart';
import 'package:flutter_component/demo/databtransfer/jd_notification.dart';
import 'package:flutter_component/demo/funcation/camera/jd_camera.dart';
import 'package:flutter_component/demo/funcation/camera/jd_pickImage.dart';

import 'package:flutter_component/demo/funcation/state/jd_state_list.dart';

import 'package:flutter_component/demo/jd_demo_list.dart';
import 'package:flutter_component/page/login/jd_login_page.dart';
import 'package:flutter_component/page/scaffold/jd_scaffold_page.dart';
import 'package:flutter_component/page/home/jd_home_page.dart';
import 'package:flutter_component/demo/tab/jd_tabbar.dart';
import 'package:flutter_component/demo/buycar/jd_buycar_page.dart';
import 'package:flutter_component/demo/thirdpary/image/jd_imageview.dart';
import 'package:flutter_component/demo/thirdpary/jd_thirdparty_list.dart';
import 'package:flutter_component/demo/thirdpary/webview/jd_webview.dart';

//final Map<String, Widget> routes = <String, Widget> {
//  '/text': TextPage(),
//};

final routes = <String, WidgetBuilder> {
  //基础类
  '/component_list': (BuildContext context) => JDComponentListPage(),
  '/text': (BuildContext context) => JDTextPage(),
  '/button': (BuildContext context) => JDButtonPage(),
  '/image': (BuildContext context) => JDImagePage(),
  '/checkbox': (BuildContext context) => JDCheckboxPage(),
  '/textfield': (BuildContext context) => JDTextFieldPage(),
  '/linearprogressindicator': (BuildContext context) => JDLinearProgressIndicatorPage(),



  //布局类
  '/rowcolumn': (BuildContext context) => JDRowColumnPage(),
  '/flex': (BuildContext context) => JDFlexPage(),
  '/wrapflow': (BuildContext context) => JDWrapFlowPage(),
  '/stackpositioned': (BuildContext context) => JDStackPositionedPage(),
  '/align': (BuildContext context) => JDAlignPage(),
  '/expanded':(context) => JDExpandedPage(),

  //容器类
  '/padding': (BuildContext context) => JDPaddingPage(),
  '/constrainedbox': (BuildContext context) => JDConstrainedBoxPage(),
  '/decoratedbox': (BuildContext context) => JDDecoratedBoxPage(),
  '/transform': (BuildContext context) => JDTransformPage(),
  '/container': (BuildContext context) => JDContainerPage(),

  //滚动类
  '/singlechildscrollview': (BuildContext context) => JDSingleChildScrollViewPage(),
  '/listview': (BuildContext context) => JDListViewPage(),
  '/gridview': (BuildContext context) => JDGridViewPage(),
  '/customscrollview': (BuildContext context) => JDCustomScrollViewPage(),
  '/nestedscrollview':(context) => JDNestedScrollViewPage(),
  '/nestedscrollview_list':(context) => JDNestedScrollViewListPage(),

  //其他
  '/demo.funcation.state': (BuildContext context) => JDStateListPage(),
  //数据传递
  '/data': (context) => JDDataTransferIndexPage(),
  '/inheritedwidget':(context) => JDInheritedWdgetPage(),
  '/notification':(context) => JDNotificationPage(),
  '/eventbus':(context) => JDEventBusPage(),
  '/stream':(context) => JDStreamPage(),

  //thirdpary
  '/webview': (context) => JDWebViewPage(),
  '/image': (context) => JDImageViewPage(),

  '/demo_list': (BuildContext context) => JDDemoListPage(),
  '/login': (BuildContext context) => JDLoginPage(),
  '/scaffold': (BuildContext context) => JDScaffoldPage(),
  '/home': (BuildContext context) => JDHomePage(),
  '/tabbar': (BuildContext context) => JDTabbarPage(),
  '/buy_car': (BuildContext context) => JDBuyCarPage(),
  '/pickImage':(context) => JDPickImagePage(),
  '/camera':(context) => CameraExampleHome(),
  '/thirdparty_list':(context) => JDThirdpartyListPage(),

};



/*************************** module *************************/

final module_list = <Map<String,String>>[{
  "title" : "Component List",
  "router" : "/component_list",
}, {
  "title" : "State",
  "router" : "/demo.funcation.state",
}, {
  "title" : "Data Transfer",
  "router" : "/data",
},{
  "title" : "Demo",
  "router" : "/demo_list",
}
];

/*************************** datalist *************************/
final data_list = <Map<String,String>>[{
  "title" : "InheritedWidget",
  "router" : "/inheritedwidget",
}, {
  "title" : "Notification",
  "router" : "/notification",
}, {
  "title" : "EventBus",
  "router" : "/eventbus",
},{
  "title" : "Stream",
  "router" : "/stream",
}
];

/*************************** demo.thirdpary *************************/
final thirdpary_list = <Map<String,String>>[{
  "title" : "WebView",
  "router" : "/webview",
}, {
  "title" : "Image",
  "router" : "/image",
}, {
  "title" : "Camera",
  "router" : "/camera",
}, {
  "title" : "EventBus",
  "router" : "/eventbus",
},{
  "title" : "Stream",
  "router" : "/stream",
}
];

/*************************** demo *************************/

final demo_list = <Map<String,String>>[{
  "title" : "Login",
  "router" : "/login",
},{
  "title" : "Scaffold",
  "router" : "/scaffold",
},{
"title" : "Tabbar",
"router" : "/tabbar",
}, {
  "title" : "购物车",
  "router" : "/buy_car",
}, {
  "title" : "拍照",
  "router" : "/pickImage",
}, {
  "title" : "第三方组件",
  "router" : "/thirdparty_list",
}
];

/*************************** demo.component *************************/

final component_list = <Map<String,String>>[
  //基础组件
{
  "title" : "Text",
  "router" : "/text",
},  {
  "title" : "Button",
  "router" : "/button",
}, {
  "title" : "Image",
  "router" : "/image",
}, {
  "title" : "CheckBox",
  "router" : "/checkbox",
}, {
  "title" : "TextField",
  "router" : "/textfield",
}, {
  "title" : "LinearProgressIndicator",
  "router" : "/linearprogressindicator",
},

//布局组件
{
  "title" : "RowColumn",
  "router" : "/rowcolumn",
}, {
  "title" : "Flex",
  "router" : "/flex",
}, {
  "title" : "WrapFlow",
  "router" : "/wrapflow",
},{
  "title" : "StackPositioned",
  "router" : "/stackpositioned",
}, {
  "title" : "Align",
  "router" : "/align",
}, {
"title" : "Expanded",
"router" : "/expanded",
},

//容器组件
{
  "title" : "Padding",
  "router" : "/padding",
},{
    "title" : "ConstrainedBox",
    "router" : "/constrainedbox",
},{
    "title" : "DecoratedBox",
    "router" : "/decoratedbox",
},{
    "title" : "TransformPage",
    "router" : "/transform",
},{
    "title" : "Container",
    "router" : "/container",
},

//滚动组件
{
    "title" : "SingleChildScrollView",
    "router" : "/singlechildscrollview",
},{
    "title" : "ListView",
    "router" : "/listview",
},{
  "title" : "GridView",
  "router" : "/gridview",
}, {
  "title" : "CustomScrollView",
  "router" : "/customscrollview",
},{
  "title" : "NestedScrollView",
  "router" : "/nestedscrollview_list"
}

];