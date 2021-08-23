import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lifecycle/lifecycle.dart';

/// @author jd

class TabbarViewLifeCycle extends StatefulWidget {
  const TabbarViewLifeCycle({this.tabController, this.child});
  final TabController tabController;
  final Widget child;

  static _TabbarViewLifeCycleState of(BuildContext context) {
    _TabbarViewLifeCycleState state =
        context.findAncestorStateOfType<_TabbarViewLifeCycleState>();
    return state;
  }

  @override
  _TabbarViewLifeCycleState createState() => _TabbarViewLifeCycleState();
}

class _TabbarViewLifeCycleState extends State<TabbarViewLifeCycle>
    with LifecycleAware {
  ///tabbar对应的每个页面注册的实例,每个tab下可能会注册多个，所以用set
  Map<num, Set<LifecycleAware>> _configList;

  //当前切换的index
  int _currentIndex;

  @override
  void initState() {
    //初始化子布局信息，监听子布局的变化，并通知对应的子页面
    _configList = {};
    for (int i = 0; i < widget.tabController.length; i++) {
      _configList[i] = {};
    }
    _currentIndex = widget.tabController.index;
    widget.tabController.addListener(() {
      final int index = widget.tabController.index;
      notification(index);
      _currentIndex = index;
    });

    //获取上层的布局，可能存在嵌套的情况
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      TabbarViewLifeCycle.of(context)?.register(context, this);
    });

    super.initState();
  }

  //通知index页面将要显示，对上个页面进行消失操作
  void notification(int index) {
    if (_currentIndex != index) {
      final Set<LifecycleAware> preLifecycle = _configList[_currentIndex];
      final Set<LifecycleAware> currentLifecycle = _configList[index];
      if (preLifecycle != null && preLifecycle.isNotEmpty) {
        preLifecycle.forEach((element) {
          element.onLifecycleEvent(LifecycleEvent.invisible);
        });
      }
      if (currentLifecycle != null && currentLifecycle.isNotEmpty) {
        currentLifecycle.forEach((element) {
          element.onLifecycleEvent(LifecycleEvent.visible);
        });
      }
    }
    _currentIndex = index;
  }

  //注册，通过context来
  void register(BuildContext context, LifecycleAware childWidget) {
    TabbarItemLifecycle item =
        context.dependOnInheritedWidgetOfExactType<TabbarItemLifecycle>();
    int index = item.index;
    Set set = _configList[index];
    set ??= {};
    set.add(childWidget);
    _configList[index] = set;
  }

  void unregister(LifecycleAware childWidget) {
    for (final int index in _configList.keys) {
      final Set<LifecycleAware> subscribers = _configList[index];
      subscribers?.remove(childWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  ///将上层的事件传递给下层
  @override
  void onLifecycleEvent(LifecycleEvent event) {
    final Set<LifecycleAware> currentLifecycle = _configList[_currentIndex];
    if (currentLifecycle != null && currentLifecycle.isNotEmpty) {
      currentLifecycle.forEach((element) {
        element.onLifecycleEvent(event);
      });
    }
  }
}

class TabbarItemLifecycle extends InheritedWidget {
  const TabbarItemLifecycle({
    Key key,
    Widget child,
    this.index,
  }) : super(key: key, child: child);
  final int index;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

mixin TabBarLifecycle<T extends StatefulWidget> on State<T>, LifecycleAware {
  _TabbarViewLifeCycleState _tabbarViewLifeCycleState;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _tabbarViewLifeCycleState = TabbarViewLifeCycle.of(context);
      _tabbarViewLifeCycleState?.register(context, this);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabbarViewLifeCycleState.unregister(this);
    super.dispose();
  }
}
