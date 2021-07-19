import 'package:flutter/material.dart';
import 'package:flutter_app_component/generated/l10n.dart';
import 'package:flutter_app_component/pages/jd_splash_page.dart';
import 'package:flutter_app_component/routes/jd_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_core/style/jd_colors.dart';
import 'package:jd_core/style/jd_theme.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:provider/provider.dart';

import 'component/orientation/orientation_observer.dart';
import 'routes/jd_routes.dart';

/**
 * flutter 相对布局
 * 一、Stack和Align配合
 * 二、Row和mainAxisAlignment.spaceBetween
 *
 * flutter 绝对布局
 * 1、Flutter和Positioned配合
 */
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //缓存个数 100
    PaintingBinding.instance.imageCache.maximumSize = 100;
//缓存大小 50m
    PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20;
    _initListener();
  }

  void _initListener() {}

  void _loadLocale() {}

  @override
  Widget build(BuildContext context) {
    final JDTheme theme = context.watch<JDTheme>();
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: () => MaterialApp(
        title: 'Flutter App',
        navigatorKey: JDNavigationUtil.getInstance().navigatorKey,
        // ignore: always_specify_types
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
          GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
          GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
        ],
        supportedLocales: S.delegate.supportedLocales,
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
        navigatorObservers: [
          defaultOrientationObserver,
          defaultLifecycleObserver,
        ],
        onGenerateRoute: JDRouter.generateRoute,
//      onUnknownRoute: (settings) => MaterialPageRoute<dynamic>(builder: (context) => JDNotFindPage()),
//      onGenerateRoute: (RouteSettings settings){
//        return MaterialPageRoute(builder: (context){
//          String routeName = settings.name;
//          print(routeName);
//          Widget widget = routes[routeName];
//          return widget;
//        });
//      },
      ),
    );
  }
}
