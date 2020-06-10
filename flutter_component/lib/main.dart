import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_component/default/jd_notfind.dart';
import 'package:flutter_component/page/jd_splash_page.dart';
import 'package:flutter_component/style/jd_colors.dart';
import 'package:flutter_component/utils/jd_navigation_util.dart';
import 'package:flutter_component/routes/jd_routes.dart';
import 'package:provider/provider.dart';
import 'global/jd_global.dart';
import 'global/jd_theme.dart';

void collectLog(String line){
   //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details){
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
  // 构建错误信息
  return null;
}

void main() {
//  debugPaintSizeEnabled = true;//显示边界布局
//  debugPaintPointersEnabled = true;   //点击效果
//  debugPaintLayerBordersEnabled = true;//显示边界
//  debugRepaintRainbowEnabled = true;//重绘时周边显示旋转色

  FlutterError.onError = (FlutterErrorDetails details) {
       //TODO 此处可以上传到自己的服务器
       reportErrorAndLog(details);
       //继续打印到控制台
       FlutterError.dumpErrorToConsole(details);

  };
  //初始化
  JDGlobal.init(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<JDGlobal>(
            create: (context)=>JDGlobal(),
          ),

          ChangeNotifierProvider<JDTheme>(
            create: (context) => JDTheme(),
          ),

        ],
        child: MyApp(),
      ),
    );
  });
//  runApp(
//      ColorFiltered(
//        colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
//        child: MyApp()
//      )
//  );

//  runZoned(
//        () => runApp(MyApp()),
//        zoneSpecification: ZoneSpecification(
//            print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//            collectLog(line); // 收集日志
//          },
//        ),
//       onError: (Object obj, StackTrace stack) {
//           var details = makeDetails(obj, stack);
//           reportErrorAndLog(details);
//        },
//  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _initListener();
  }


  void _initListener() {
  }

  void _loadLocale() {

  }

  @override
  Widget build(BuildContext context) {
    JDTheme theme = context.watch<JDTheme>();
    return MaterialApp(
      title: 'Flutter App',
      navigatorKey: JDNavigationUtil.getInstance().navigatorKey,
//      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //深色还是浅色
        brightness: Brightness.light,
        //主题色，决定导航颜色
        primaryColor: theme.navigationBackgroundColor,
        //主题次级色，决定大多数Widget的颜色，如进度条、开关等
        accentColor: theme.navigationBackgroundColor,
        //选项卡中选定的选项卡指示器的颜色
        indicatorColor: JDColors.text_normal,

        primarySwatch: Colors.blue,
      ),
      home: JDSplashPage(),
//      routes: routes,
      onGenerateRoute: Router.generateRoute,
//      onUnknownRoute: (settings) => MaterialPageRoute<dynamic>(builder: (context) => JDNotFindPage()),
//      onGenerateRoute: (RouteSettings settings){
//        return MaterialPageRoute(builder: (context){
//          String routeName = settings.name;
//          print(routeName);
//          Widget widget = routes[routeName];
//          return widget;
//        });
//      },
    );
  }
}

