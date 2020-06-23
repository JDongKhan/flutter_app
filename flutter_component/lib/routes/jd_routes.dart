import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/default/jd_notfind.dart';
import 'package:flutter_component/demo/buycar/jd_buycar_page.dart';
import 'package:flutter_component/demo/component/align/jd_align.dart';
import 'package:flutter_component/demo/component/button/jd_button.dart';
import 'package:flutter_component/demo/component/checkbox/jd_checkbox.dart';
import 'package:flutter_component/demo/component/constrainedbox/jd_constrainedbox.dart';
import 'package:flutter_component/demo/component/container/jd_container.dart';
import 'package:flutter_component/demo/component/customscrollview/jd_customscrollview.dart';
import 'package:flutter_component/demo/component/decoratedbox/jd_decoratedbox.dart';
import 'package:flutter_component/demo/component/expanded/jd_expanded.dart';
import 'package:flutter_component/demo/component/flex/jd_flex.dart';
import 'package:flutter_component/demo/component/flow/jd_flow_page.dart';
import 'package:flutter_component/demo/component/gridview/jd_gridview.dart';
import 'package:flutter_component/demo/component/image/jd_image.dart';
import 'package:flutter_component/demo/component/jd_component_list.dart';
import 'package:flutter_component/demo/component/linearprogressindicator/jd_linearprogressindicator.dart';
import 'package:flutter_component/demo/component/listview/jd_listview.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview_list.dart';
import 'package:flutter_component/demo/component/padding/jd_padding.dart';
import 'package:flutter_component/demo/component/row_column/jd_row_column.dart';
import 'package:flutter_component/demo/component/singlechildscrollView/jd_singlechildscrollView.dart';
import 'package:flutter_component/demo/component/stack_positioned/jd_stack_positioned.dart';
import 'package:flutter_component/demo/component/text/jd_text.dart';
import 'package:flutter_component/demo/component/textfield/jd_textfield.dart';
import 'package:flutter_component/demo/component/transform/jd_transform.dart';
import 'package:flutter_component/demo/component/wrap_flow/jd_wrap_flow.dart';
import 'package:flutter_component/demo/databtransfer/jd_event_bus.dart';
import 'package:flutter_component/demo/databtransfer/jd_index.dart';
import 'package:flutter_component/demo/databtransfer/jd_inherited_widget.dart';
import 'package:flutter_component/demo/databtransfer/jd_notification.dart';
import 'package:flutter_component/demo/databtransfer/jd_stream.dart';
import 'package:flutter_component/demo/douyin/jd_douyin_page.dart';
import 'package:flutter_component/demo/funcation/camera/jd_camera.dart';
import 'package:flutter_component/demo/funcation/camera/jd_pickImage.dart';
import 'package:flutter_component/demo/funcation/state/jd_state_list.dart';
import 'package:flutter_component/demo/jd_demo_list.dart';
import 'package:flutter_component/demo/tab/jd_tabbar.dart';
import 'package:flutter_component/demo/thirdpary/image/jd_imageview.dart';
import 'package:flutter_component/demo/thirdpary/jd_thirdparty_list.dart';
import 'package:flutter_component/demo/thirdpary/webview/jd_webview.dart';
import 'package:flutter_component/page/home/jd_home_page.dart';
import 'package:flutter_component/page/login/jd_login_page.dart';
import 'package:flutter_component/page/scaffold/jd_scaffold_page.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  //基础类
  '/component_list': (BuildContext context) => JDComponentListPage(),
  '/text': (BuildContext context) => JDTextPage(),
  '/button': (BuildContext context) => JDButtonPage(),
  '/image': (BuildContext context) => JDImagePage(),
  '/checkbox': (BuildContext context) => JDCheckboxPage(),
  '/textfield': (BuildContext context) => JDTextFieldPage(),
  '/linearprogressindicator': (BuildContext context) =>
      JDLinearProgressIndicatorPage(),

  //布局类
  '/rowcolumn': (BuildContext context) => JDRowColumnPage(),
  '/flex': (BuildContext context) => JDFlexPage(),
  '/wrapflow': (BuildContext context) => JDWrapFlowPage(),
  '/flow': (BuildContext context) => JDFlowPage(),
  '/stackpositioned': (BuildContext context) => JDStackPositionedPage(),
  '/align': (BuildContext context) => JDAlignPage(),
  '/expanded': (context) => JDExpandedPage(),

  //容器类
  '/padding': (BuildContext context) => JDPaddingPage(),
  '/constrainedbox': (BuildContext context) => JDConstrainedBoxPage(),
  '/decoratedbox': (BuildContext context) => JDDecoratedBoxPage(),
  '/transform': (BuildContext context) => JDTransformPage(),
  '/container': (BuildContext context) => JDContainerPage(),

  //滚动类
  '/singlechildscrollview': (BuildContext context) =>
      JDSingleChildScrollViewPage(),
  '/listview': (BuildContext context) => JDListViewPage(),
  '/gridview': (BuildContext context) => JDGridViewPage(),
  '/customscrollview': (BuildContext context) => JDCustomScrollViewPage(),
  '/nestedscrollview': (BuildContext context) => JDNestedScrollViewPage(),
  '/nestedscrollview_list': (BuildContext context) =>
      JDNestedScrollViewListPage(),

  //其他
  '/demo.funcation.state': (BuildContext context) => JDStateListPage(),
  //数据传递
  '/data': (BuildContext context) => JDDataTransferIndexPage(),
  '/inheritedwidget': (BuildContext context) => JDInheritedWdgetPage(),
  '/notification': (BuildContext context) => JDNotificationPage(),
  '/eventbus': (BuildContext context) => JDEventBusPage(),
  '/stream': (BuildContext context) => JDStreamPage(),

  //三方
  '/webview': (BuildContext context) => JDWebViewPage(),
  '/image': (BuildContext context) => JDImageViewPage(),
//  '/player': (BuildContext context) => JDPlayer(),

  '/demo_list': (BuildContext context) => JDDemoListPage(),
  '/login': (BuildContext context) => JDLoginPage(),
  '/scaffold': (BuildContext context) => JDScaffoldPage(),
  '/home': (BuildContext context) => JDHomePage(),
  '/tabbar': (BuildContext context) => JDTabbarPage(),
  '/douyin': (BuildContext context) => JDDouyinPage(),
  '/buy_car': (BuildContext context) => JDBuyCarPage(),
  '/pickImage': (BuildContext context) => JDPickImagePage(),
  '/camera': (BuildContext context) => CameraExampleHome(),
  '/thirdparty_list': (BuildContext context) => JDThirdpartyListPage(),
};

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final WidgetBuilder builder = routes[settings.name];
    return CupertinoPageRoute<dynamic>(
      builder: builder ?? (BuildContext context) => JDNotFindPage(),
    );
  }
}
