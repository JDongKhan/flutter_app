import 'package:flutter/material.dart';

/// @author jd

/// 执行顺序
/// 子类的方法>D3>D2>D1>super
abstract class DemoSuperClass {
  void printMessage() {
    debugPrint('JDDemoSuperClass printMessage');
  }
}

class Demo1 extends DemoSuperClass with D_1, D_2, D_3 {
  @override
  void printMessage() {
    debugPrint('JDDemo1 printMessage');
    super.printMessage();
  }
}

mixin D_1 on DemoSuperClass {
  @override
  void printMessage() {
    debugPrint('D_1 printMessage');
    super.printMessage();
  }
}

mixin D_2 on DemoSuperClass {
  @override
  void printMessage() {
    debugPrint('D_2 printMessage');
    super.printMessage();
  }
}

mixin D_3 on DemoSuperClass {
  @override
  void printMessage() {
    debugPrint('D_3 printMessage');
    super.printMessage();
  }
}

extension D_4 on Demo1 {
  ///已经存在的方法添加不进去
  void printMessage() {
    debugPrint('D_4 printMessage');
  }

  ///可以添加不存在的方法
  void printMessage1() {
    debugPrint('D_4 printMessage');
  }
}
