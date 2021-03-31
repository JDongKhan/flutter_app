import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_path_utils.dart';
import 'package:jd_core/utils/jd_storage_utils.dart';

/// @author jd
///
enum JDPlatform {
  iOS,
  android,
  web,
  linux,
  macOS,
  windows,
}

class JDAppInfo {
  static bool get isAndroid => platform() == JDPlatform.android;
  static bool get isIOS => platform() == JDPlatform.iOS;
  static bool get isWeb => platform() == JDPlatform.web;
  static bool get isLinux => platform() == JDPlatform.linux;
  static bool get isMacOS => platform() == JDPlatform.macOS;
  static bool get isWindow => platform() == JDPlatform.windows;

  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;
  //初始化
  static void init(VoidCallback callback) {
    WidgetsFlutterBinding.ensureInitialized();
    //异步初始化
    JDAppInfo.delayInit();
    //布局
    callback();
    //强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (JDAppInfo.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      const SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  //初始化全局信息
  // ignore: always_specify_types
  static Future delayInit() async {
    //初始化
    StorageUtil.getInstance();
    //初始化bugly
//    FlutterBugly.init(androidAppId: "your android app id",iOSAppId: "your iOS app id");
//    FlutterBugly.setUserId("user id");
//    FlutterBugly.putUserData(key: "key", value: "value");
//    int tag = 9527;
//    FlutterBugly.setUserTag(tag);
//
    return temporaryDirectory = await JDPathUtils.getAppTemporaryDirectory();
  }

  //隐藏显示状态栏
  static void toggleFullScreen(bool fullscreen) {
    fullscreen
        ? SystemChrome.setEnabledSystemUIOverlays([])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static JDPlatform platform() {
    if (kIsWeb) {
      return JDPlatform.web;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return JDPlatform.iOS;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return JDPlatform.android;
    }
    if (defaultTargetPlatform == TargetPlatform.linux) {
      return JDPlatform.linux;
    }
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      return JDPlatform.macOS;
    }
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return JDPlatform.windows;
    }
  }
}
