import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/camera/camera.dart';
import 'package:flutter_app_component/demo/camera/pickImage.dart';
import 'package:flutter_app_component/demo/component/align/align_page.dart';
import 'package:flutter_app_component/demo/component/button/button_page.dart';
import 'package:flutter_app_component/demo/component/checkbox/checkbox_page.dart';
import 'package:flutter_app_component/demo/component/constrainedbox/constrainedbox_page.dart';
import 'package:flutter_app_component/demo/component/container/container_page.dart';
import 'package:flutter_app_component/demo/component/customscrollview/customscrollview_page.dart';
import 'package:flutter_app_component/demo/component/decoratedbox/decoratedbox_page.dart';
import 'package:flutter_app_component/demo/component/expanded/expanded_page.dart';
import 'package:flutter_app_component/demo/component/flex/flex_page.dart';
import 'package:flutter_app_component/demo/component/flow/flow_page.dart';
import 'package:flutter_app_component/demo/component/gridview/gridview_page.dart';
import 'package:flutter_app_component/demo/component/image/image_page.dart';
import 'package:flutter_app_component/demo/component/linearprogressindicator/linearprogressindicator_page.dart';
import 'package:flutter_app_component/demo/component/listview/listview_page.dart';
import 'package:flutter_app_component/demo/component/nestedscrollview/nestedscrollview_list_page.dart';
import 'package:flutter_app_component/demo/component/nestedscrollview/nestedscrollview_page.dart';
import 'package:flutter_app_component/demo/component/padding/padding_page.dart';
import 'package:flutter_app_component/demo/component/row_column/row_column_page.dart';
import 'package:flutter_app_component/demo/component/singlechildscrollView/singlechildscrollview_page.dart';
import 'package:flutter_app_component/demo/component/stack_positioned/stack_positioned_page.dart';
import 'package:flutter_app_component/demo/component/tabbar/tabbar_page.dart';
import 'package:flutter_app_component/demo/component/text/text_page.dart';
import 'package:flutter_app_component/demo/component/textfield/textfield_page.dart';
import 'package:flutter_app_component/demo/component/transform/transform_page.dart';
import 'package:flutter_app_component/demo/component/wrap_flow/wrap_flow_page.dart';
import 'package:flutter_app_component/demo/databtransfer/data_transfer_index.dart';
import 'package:flutter_app_component/demo/databtransfer/event_bus/event_bus_page.dart';
import 'package:flutter_app_component/demo/databtransfer/inherited_widget_page.dart';
import 'package:flutter_app_component/demo/databtransfer/notification_page.dart';
import 'package:flutter_app_component/demo/databtransfer/stream_page.dart';
import 'package:flutter_app_component/demo/douyin/douyin_main_page.dart';
import 'package:flutter_app_component/demo/funcation/state/state_list_page.dart';
import 'package:flutter_app_component/demo/sports/sports_tabbar.dart';
import 'package:flutter_app_component/demo/style_card/stacked_card_demo.dart';
import 'package:flutter_app_component/demo/thirdpary/image/image_page.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player_demo_page.dart';
import 'package:flutter_app_component/demo/thirdpary/thirdparty_list.dart';
import 'package:flutter_app_component/demo/thirdpary/webview/webview_page.dart';
import 'package:flutter_app_component/global/notfind.dart';
import 'package:flutter_app_component/pages/login/login_page.dart';
import 'package:flutter_app_component/pages/scaffold/scaffold_page.dart';
import 'package:jd_home/pages/home/home_page.dart';

final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => ScaffoldPage(),

  //基础类
  '/text': (BuildContext context) => TextPage(),
  '/button': (BuildContext context) => ButtonPage(),
  '/image': (BuildContext context) => ImagePage(),
  '/checkbox': (BuildContext context) => CheckboxPage(),
  '/textfield': (BuildContext context) => TextFieldPage(),
  '/linearprogressindicator': (BuildContext context) =>
      LinearProgressIndicatorPage(),

  //布局类
  '/rowcolumn': (BuildContext context) => RowColumnPage(),
  '/flex': (BuildContext context) => FlexPage(),
  '/wrapflow': (BuildContext context) => WrapFlowPage(),
  '/flow': (BuildContext context) => FlowPage(),
  '/stackpositioned': (BuildContext context) => StackPositionedPage(),
  '/align': (BuildContext context) => AlignPage(),
  '/expanded': (BuildContext context) => ExpandedPage(),

  //容器类
  '/padding': (BuildContext context) => PaddingPage(),
  '/constrainedbox': (BuildContext context) => ConstrainedBoxPage(),
  '/decoratedbox': (BuildContext context) => DecoratedBoxPage(),
  '/transform': (BuildContext context) => TransformPage(),
  '/container': (BuildContext context) => ContainerPage(),

  //滚动类
  '/singlechildscrollview': (BuildContext context) =>
      SingleChildScrollViewPage(),
  '/listview': (BuildContext context) => ListViewPage(),
  '/gridview': (BuildContext context) => GridViewPage(),
  '/customscrollview': (BuildContext context) => CustomScrollViewPage(),
  '/nestedscrollview': (BuildContext context) => NestedScrollViewPage(),
  '/nestedscrollview_list': (BuildContext context) =>
      NestedScrollViewListPage(),

  //其他
  '/demo.funcation.state': (BuildContext context) => StateListPage(),
  //数据传递
  '/data': (BuildContext context) => DataTransferIndexPage(),
  '/inheritedwidget': (BuildContext context) => InheritedWdgetPage(),
  '/notification': (BuildContext context) => NotificationPage(),
  '/eventbus': (BuildContext context) => EventBusPage(),
  '/stream': (BuildContext context) => StreamPage(),

  //三方
  '/webview': (BuildContext context) => WebViewPage(),
  '/imageView': (BuildContext context) => ImageViewPage(),
  '/stacked_card': (BuildContext context) => StackedCardDemo(),
  '/player': (BuildContext context) => PlayerDemoPage(),

  '/login': (BuildContext context) => LoginPage(),
  '/scaffold': (BuildContext context) => ScaffoldPage(),
  '/home': (BuildContext context) => HomePage(),
  '/tabbar': (BuildContext context) => SportsTabbarPage(),
  '/tabbar_component': (BuildContext context) => TabbarPage(),
  '/douyin': (BuildContext context) => DouyinMainPage(),
  '/pickImage': (BuildContext context) => PickImagePage(),
  '/camera': (BuildContext context) => CameraExampleHome(),
  '/thirdparty_list': (BuildContext context) => ThirdpartyListPage(),
};

Map<String, WidgetBuilder> get routes => _routes;

class JDRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final WidgetBuilder builder = routes[settings.name];
    return CupertinoPageRoute<dynamic>(
      builder: builder ?? (BuildContext context) => JDNotFindPage(),
    );
  }
}
