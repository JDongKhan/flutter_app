import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/buycar/jd_buycar_page.dart';
import 'package:flutter_app_component/demo/camera/jd_camera.dart';
import 'package:flutter_app_component/demo/camera/jd_pickImage.dart';
import 'package:flutter_app_component/demo/component/align/jd_align.dart';
import 'package:flutter_app_component/demo/component/button/jd_button.dart';
import 'package:flutter_app_component/demo/component/checkbox/jd_checkbox.dart';
import 'package:flutter_app_component/demo/component/constrainedbox/jd_constrainedbox.dart';
import 'package:flutter_app_component/demo/component/container/jd_container.dart';
import 'package:flutter_app_component/demo/component/customscrollview/jd_customscrollview.dart';
import 'package:flutter_app_component/demo/component/decoratedbox/jd_decoratedbox.dart';
import 'package:flutter_app_component/demo/component/expanded/jd_expanded.dart';
import 'package:flutter_app_component/demo/component/flex/jd_flex.dart';
import 'package:flutter_app_component/demo/component/flow/jd_flow_page.dart';
import 'package:flutter_app_component/demo/component/gridview/jd_gridview.dart';
import 'package:flutter_app_component/demo/component/image/jd_image.dart';
import 'package:flutter_app_component/demo/component/linearprogressindicator/jd_linearprogressindicator.dart';
import 'package:flutter_app_component/demo/component/listview/jd_listview.dart';
import 'package:flutter_app_component/demo/component/nestedscrollview/jd_nestedscrollview.dart';
import 'package:flutter_app_component/demo/component/nestedscrollview/jd_nestedscrollview_list.dart';
import 'package:flutter_app_component/demo/component/padding/jd_padding.dart';
import 'package:flutter_app_component/demo/component/row_column/jd_row_column.dart';
import 'package:flutter_app_component/demo/component/singlechildscrollView/jd_singlechildscrollView.dart';
import 'package:flutter_app_component/demo/component/stack_positioned/jd_stack_positioned.dart';
import 'package:flutter_app_component/demo/component/tabbar/jd_tabbar.dart';
import 'package:flutter_app_component/demo/component/text/jd_text.dart';
import 'package:flutter_app_component/demo/component/textfield/jd_textfield.dart';
import 'package:flutter_app_component/demo/component/transform/jd_transform.dart';
import 'package:flutter_app_component/demo/component/wrap_flow/jd_wrap_flow.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_event_bus.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_index.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_inherited_widget.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_notification.dart';
import 'package:flutter_app_component/demo/databtransfer/jd_stream.dart';
import 'package:flutter_app_component/demo/douyin/jd_douyin_page.dart';
import 'package:flutter_app_component/demo/funcation/state/jd_state_list.dart';
import 'package:flutter_app_component/demo/tab/jd_tabbar.dart';
import 'package:flutter_app_component/demo/thirdpary/image/jd_imageview.dart';
import 'package:flutter_app_component/demo/thirdpary/jd_thirdparty_list.dart';
import 'package:flutter_app_component/demo/thirdpary/webview/jd_webview.dart';
import 'package:flutter_app_component/global/jd_notfind.dart';
import 'package:flutter_app_component/pages/login/jd_login_page.dart';
import 'package:flutter_app_component/pages/scaffold/jd_scaffold_page.dart';
import 'package:jd_home/pages/home/jd_home_page.dart';

final Map<String, Widget> _routes = <String, Widget>{
  '/': JDScaffoldPage(),

  //基础类
  '/text': JDTextPage(),
  '/button': JDButtonPage(),
  '/image': JDImagePage(),
  '/checkbox': JDCheckboxPage(),
  '/textfield': JDTextFieldPage(),
  '/linearprogressindicator': JDLinearProgressIndicatorPage(),

  //布局类
  '/rowcolumn': JDRowColumnPage(),
  '/flex': JDFlexPage(),
  '/wrapflow': JDWrapFlowPage(),
  '/flow': JDFlowPage(),
  '/stackpositioned': JDStackPositionedPage(),
  '/align': JDAlignPage(),
  '/expanded': JDExpandedPage(),

  //容器类
  '/padding': JDPaddingPage(),
  '/constrainedbox': JDConstrainedBoxPage(),
  '/decoratedbox': JDDecoratedBoxPage(),
  '/transform': JDTransformPage(),
  '/container': JDContainerPage(),

  //滚动类
  '/singlechildscrollview': JDSingleChildScrollViewPage(),
  '/listview': JDListViewPage(),
  '/gridview': JDGridViewPage(),
  '/customscrollview': JDCustomScrollViewPage(),
  '/nestedscrollview': JDNestedScrollViewPage(),
  '/nestedscrollview_list': JDNestedScrollViewListPage(),

  //其他
  '/demo.funcation.state': JDStateListPage(),
  //数据传递
  '/data': JDDataTransferIndexPage(),
  '/inheritedwidget': JDInheritedWdgetPage(),
  '/notification': JDNotificationPage(),
  '/eventbus': JDEventBusPage(),
  '/stream': JDStreamPage(),

  //三方
  '/webview': JDWebViewPage(),
  '/imageView': JDImageViewPage(),
//  '/player':  JDPlayer(),

  '/login': JDLoginPage(),
  '/scaffold': JDScaffoldPage(),
  '/home': JDHomePage(),
  '/tabbar': JDTabbarPage(),
  '/tabbar_component': JDTabbar(),
  '/douyin': JDDouyinPage(),
  '/buy_car': JDBuyCarPage(),
  '/pickImage': JDPickImagePage(),
  '/camera': CameraExampleHome(),
  '/thirdparty_list': JDThirdpartyListPage(),
};

final Map<String, WidgetBuilder> routes = _routes.map(
  (String key, Widget value) => MapEntry<String, WidgetBuilder>(
    key,
    (BuildContext context) => value,
  ),
);

class JDRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final WidgetBuilder builder = routes[settings.name];
    return CupertinoPageRoute<dynamic>(
      builder: builder ?? (BuildContext context) => JDNotFindPage(),
    );
  }
}
