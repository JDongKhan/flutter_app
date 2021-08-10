import 'package:flutter/material.dart';

import 'life_cycle_demo_1.dart';

/// @author jd

extension D_5 on Demo1 {
  ///可以添加不存在的方法
  void printMessage2() {
    debugPrint('D_5 printMessage');
  }
}
