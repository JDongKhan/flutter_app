import 'package:flutter/foundation.dart';

class Constant {
  static const String keyLanguage = 'key_language';
  static const String key_theme_color = 'key_theme_color';
  static const String key_guide = 'key_guide';

}

class AppConfig {
  static const String appName = 'JDApp';
  static const bool isDebug = kDebugMode;
}

class LoadStatus {
  static const int fail = -1;
  static const int loading = 0;
  static const int success = 1;
  static const int empty = 2;
}
