import 'dart:math';

import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDTheme extends ChangeNotifier {

  Color navigationBackgroundColor = Color(0xFFEEEEEE);
  Color navigationTextColor = Color(0xFF666666);
  /// 当前主题颜色
  MaterialColor _themeColor;

  void switchTheme({MaterialColor color}) {
    _themeColor = color ?? _themeColor;
    navigationBackgroundColor = _themeColor;
    notifyListeners();
  }


  /// 随机一个主题色彩
  ///
  /// 可以指定明暗模式,不指定则保持不变
  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
      color: Colors.primaries[colorIndex],
    );
  }

}
