import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDShareDataWidget<T> extends InheritedWidget {

  JDShareDataWidget({
    @required this.data,
    Widget child
  }) :super(child: child);

  T data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static JDShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<JDShareDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(JDShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`demo.funcation.state.didChangeDependencies`会被调用
    return true;
  }

}