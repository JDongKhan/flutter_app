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
import 'package:flutter_app_component/demo/douyin/douyin_page.dart';
import 'package:flutter_app_component/demo/funcation/state/state_list_page.dart';
import 'package:flutter_app_component/demo/sports/sports_tabbar.dart';
import 'package:flutter_app_component/demo/style_card/stacked_card_demo.dart';
import 'package:flutter_app_component/demo/thirdpary/image/image_page.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player_demo_page.dart';
import 'package:flutter_app_component/demo/thirdpary/thirdparty_list.dart';
import 'package:flutter_app_component/demo/thirdpary/webview/webview_page.dart';
import 'package:flutter_app_component/global/jd_notfind.dart';
import 'package:flutter_app_component/pages/login/login_page.dart';
import 'package:flutter_app_component/pages/scaffold/scaffold_page.dart';
import 'package:jd_home/pages/home_page.dart';

final Map<String, Widget> _routes = <String, Widget>{
  '/': ScaffoldPage(),

  //基础类
  '/text': TextPage(),
  '/button': ButtonPage(),
  '/image': ImagePage(),
  '/checkbox': CheckboxPage(),
  '/textfield': TextFieldPage(),
  '/linearprogressindicator': LinearProgressIndicatorPage(),

  //布局类
  '/rowcolumn': RowColumnPage(),
  '/flex': FlexPage(),
  '/wrapflow': WrapFlowPage(),
  '/flow': FlowPage(),
  '/stackpositioned': StackPositionedPage(),
  '/align': AlignPage(),
  '/expanded': ExpandedPage(),

  //容器类
  '/padding': PaddingPage(),
  '/constrainedbox': ConstrainedBoxPage(),
  '/decoratedbox': DecoratedBoxPage(),
  '/transform': TransformPage(),
  '/container': ContainerPage(),

  //滚动类
  '/singlechildscrollview': SingleChildScrollViewPage(),
  '/listview': ListViewPage(),
  '/gridview': GridViewPage(),
  '/customscrollview': CustomScrollViewPage(),
  '/nestedscrollview': NestedScrollViewPage(),
  '/nestedscrollview_list': NestedScrollViewListPage(),

  //其他
  '/demo.funcation.state': StateListPage(),
  //数据传递
  '/data': DataTransferIndexPage(),
  '/inheritedwidget': InheritedWdgetPage(),
  '/notification': NotificationPage(),
  '/eventbus': EventBusPage(),
  '/stream': StreamPage(),

  //三方
  '/webview': WebViewPage(),
  '/imageView': ImageViewPage(),
  '/stacked_card': StackedCardDemo(),
  '/player': PlayerDemoPage(),

  '/login': LoginPage(),
  '/scaffold': ScaffoldPage(),
  '/home': HomePage(),
  '/tabbar': SportsTabbarPage(),
  '/tabbar_component': TabbarPage(),
  '/douyin': DouyinPage(),
  '/pickImage': PickImagePage(),
  '/camera': CameraExampleHome(),
  '/thirdparty_list': ThirdpartyListPage(),
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
