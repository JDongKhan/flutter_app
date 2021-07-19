import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

// 该方法用于在Dart中获取模板类型
//Type _typeOf<T>() => T;

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class JDInheritedProvider<T> extends InheritedWidget {
  JDInheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(JDInheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}


class JDChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  JDChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context) {
//    final type = _typeOf<JDInheritedProvider<T>>();
//    final provider =  context.inheritFromWidgetOfExactType(type) as JDInheritedProvider<T>;
    final provider = context.dependOnInheritedWidgetOfExactType<JDInheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();

}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<JDChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    // ignore: always_specify_types
    setState((){});
  }

  @override
  void didUpdateWidget(JDChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return JDInheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}