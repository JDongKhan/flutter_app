import 'package:flutter/foundation.dart';

enum JDEnvironmentMode {
  PRD,
  PRE,
  SIT,
  DEV,
}

enum JDAppChannel {
  //AppStore
  APPSTORE,
  //企业包
  ENTERPRISE,
  //Test
  TEST,
  //DEBUG
  DEBUG,
}

class Constant {
  static const String keyLanguage = 'key_language';
  static const String key_theme_color = 'key_theme_color';
  static const String key_guide = 'key_guide';
}

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static const String appName = 'JDApp';
  static const bool isDebug = kDebugMode;

  //环境标识
  static JDEnvironmentMode envMode = JDEnvironmentMode.PRD;
  static JDAppChannel appChannel = JDAppChannel.APPSTORE;
  //是否已经发布
  static bool get isProduct =>
      appChannel == JDAppChannel.APPSTORE ||
      appChannel == JDAppChannel.ENTERPRISE;
}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}
