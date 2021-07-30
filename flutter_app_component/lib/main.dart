import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart';
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart';
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart';
import 'package:flutter_ume_kit_show_code/flutter_ume_kit_show_code.dart';
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart';
import 'package:jd_core/style/jd_theme.dart';
import 'package:jd_core/utils/jd_appinfo.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'component/environment/environment_page.dart';
import 'component/logger/ume_logger/logger_plugin.dart';
import 'demo/login/second/common/user_center_view_model.dart';
import 'global/jd_appuserinfo.dart';
import 'pages/error_page.dart';

void collectLog(String line) {
  //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details) {
  // 上报错误和日志逻辑
  // print(details);
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return null;
}

void initProject() async {
  // window.onDrawFrame = null;
  // window.onBeginFrame = null;

  //错误信息提示
  ErrorWidget.builder = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
    return ErrorPage(
        details.exception.toString() + "\n " + details.stack.toString(),
        details);
  };

  //初始化
  JDAppInfo.init(() {
    if (kDebugMode) {
      PluginManager.instance
        ..register(WidgetInfoInspector())
        ..register(WidgetDetailInspector())
        ..register(ColorSucker())
        ..register(AlignRuler())
        ..register(Performance())
        ..register(ShowCode())
        ..register(MemoryInfoPage())
        ..register(CpuInfoPage())
        ..register(DeviceInfoPanel())
        ..register(Console())
        ..register(LoggerPlugin())
        ..register(EnvironmentPage());
      runApp(
        injectUMEWidget(child: _mainApp(), enable: true),
      );
    } else {
      runApp(
        _mainApp(),
      );
    }
  });
}

Widget _mainApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<UserCenterViewModel>(
        create: (BuildContext context) => UserCenterViewModel(),
      ),
      ChangeNotifierProvider<JDAppUserInfo>(
        create: (BuildContext context) => JDAppUserInfo(),
      ),
      ChangeNotifierProvider<JDTheme>(
        create: (BuildContext context) => JDTheme(),
      ),
    ],
    child: MyApp(),
  );
}

void initIOSAndAndroid() {
  //ios、android相关代码
  FlutterBugly.postCatchedException(() {
    initProject();
  }, handler: (FlutterErrorDetails details) {
    //继续打印到控制台
    FlutterError.dumpErrorToConsole(details, forceReport: true);
  });
}

void initOther() {
  FlutterError.onError = (FlutterErrorDetails details) {
    //TODO 此处可以上传到自己的服务器
    reportErrorAndLog(details);
    //继续打印到控制台
    FlutterError.dumpErrorToConsole(details, forceReport: true);
  };
  // Some desktop specific code there
  initProject();
}

void main() {
//
  //可以从编译参数获取环境变量，用以更改
  const String env = String.fromEnvironment('Env', defaultValue: 'prd');

  print('env:$env');

  if (JDAppInfo.isAndroid || JDAppInfo.isIOS) {
    // Some android/ios specific code
    //ios、android相关代码
    initIOSAndAndroid();
  } else if (JDAppInfo.isWeb) {
    initOther();
  } else if (JDAppInfo.isLinux || JDAppInfo.isMacOS || JDAppInfo.isWindow) {
    initOther();
  } else {
    initOther();
    // Some web specific code there
  }
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
