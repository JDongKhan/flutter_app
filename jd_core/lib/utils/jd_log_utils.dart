import 'package:flutter/widgets.dart';

/// 这个使用flutter日志打印
class LogUtils {
  static const String _defTag = 'FlutterLogUtils';
  //是否是debug模式,true: log v 不输出.
  static bool _debugMode = true;
  static int _maxLen = 128;
  static String _tagValue = _defTag;

  static void init({
    String tag = _defTag,
    bool isDebug = false,
    int maxLen = 128,
  }) {
    _tagValue = tag;
    _debugMode = isDebug;
    _maxLen = maxLen;
  }

  ///打印debug日志
  static void d(Object object, {String tag}) {
    if (_debugMode) {
      _printLog(tag, ' d ', object);
    }
  }

  ///打印error日志
  static void e(Object object, {String tag}) {
    _printLog(tag, ' e ', object);
  }

  ///打印v日志
  static void v(Object object, {String tag}) {
    if (_debugMode) {
      _printLog(tag, ' v ', object);
    }
  }

  ///打印info日志
  static void i(Object object, {String tag}) {
    if (_debugMode) {
      _printLog(tag, ' i ', object);
    }
  }

  ///打印ware警告日志
  static void w(Object object, {String tag}) {
    if (_debugMode) {
      _printLog(tag, ' w ', object);
    }
  }

  static void _printLog(String tag, String stag, Object object) {
    String da = object?.toString() ?? 'null';
    if (tag == null || tag.isEmpty) {
      tag = _tagValue;
    }
    if (da.length <= _maxLen) {
      print('$tag$stag $da');
      return;
    }
    print('$tag$stag — — — — — — — — — — st — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (da.length > _maxLen) {
        print('$tag$stag| ${da.substring(0, _maxLen)}');
        da = da.substring(_maxLen, da.length);
      } else {
        print('$tag$stag| $da');
        da = '';
      }
    }
    debugPrint('$tag$stag — — — — — — — — — — ed — — — — — — — — — ---— —');
  }
}
