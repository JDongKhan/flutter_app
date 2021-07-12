/// @author jd

/// 执行顺序
/// 子类的方法>D3>D2>D1>super
abstract class JDDemoSuperClass {
  void printMessage() {
    print('JDDemoSuperClass printMessage');
  }
}

class JDDemo1 extends JDDemoSuperClass with D_1, D_2, D_3 {
  @override
  void printMessage() {
    print('JDDemo1 printMessage');
    super.printMessage();
  }
}

mixin D_1 on JDDemoSuperClass {
  @override
  void printMessage() {
    print('D_1 printMessage');
    super.printMessage();
  }
}

mixin D_2 on JDDemoSuperClass {
  @override
  void printMessage() {
    print('D_2 printMessage');
    super.printMessage();
  }
}

mixin D_3 on JDDemoSuperClass {
  @override
  void printMessage() {
    print('D_3 printMessage');
    super.printMessage();
  }
}

extension D_4 on JDDemo1 {
  ///已经存在的方法添加不进去
  void printMessage() {
    print('D_4 printMessage');
  }

  ///可以添加不存在的方法
  void printMessage1() {
    print('D_4 printMessage');
  }
}
