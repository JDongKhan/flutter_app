import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../view_model.dart';

/// @author jd
class ProviderWidget<T extends ViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model) builder;

  ///根据model状态构建页面
  final T model;

  ///model创建好后会调用此方法，根据需要传入
  final void Function(T) onModelReady;

  const ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.onModelReady,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ViewModel>
    extends State<ProviderWidget<T>> {
  @override
  void initState() {
    //开始加载数据
    if (widget.onModelReady != null) {
      widget.onModelReady(widget.model);
    } else {
      widget.model.initData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.model,
      child: Builder(
        builder: (BuildContext c) {
          ViewModel model = c.watch<T>();
          Widget child;
          if (model.idle) {
            child = Container();
          } else if (model.busy) {
            child = CircleProgressWidget();
          } else if (model.error) {
            child = Text(
              model.errorMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            );
          } else {
            child = widget.builder(
              context,
              model,
            );
          }
          return child;
        },
      ),
    );
  }
}

class Provider2Widget<T1 extends ViewModel, T2 extends ViewModel>
    extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  ///根据model状态构建页面
  final T1 model1;
  final T2 model2;

  ///model创建好后会调用此方法，根据需要传入
  final void Function(T1, T2) onModelReady;

  ///model创建好后会调用此方法，根据需要传入

  const Provider2Widget({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    this.onModelReady,
  }) : super(key: key);

  _Provider2WidgetState<T1, T2> createState() =>
      _Provider2WidgetState<T1, T2>();
}

class _Provider2WidgetState<T1 extends ViewModel, T2 extends ViewModel>
    extends State<Provider2Widget<T1, T2>> {
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(widget.model1, widget.model2);
    } else {
      widget.model1.initData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<T1>(
          create: (BuildContext context) => widget.model1,
        ),
        ChangeNotifierProvider<T2>(
          create: (BuildContext context) => widget.model2,
        ),
      ],
      child: Builder(
        builder: (BuildContext c) {
          return widget.builder(c);
        },
      ),
    );
  }
}

class Provider3Widget<T1 extends ViewModel, T2 extends ViewModel,
    T3 extends ViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  ///根据model状态构建页面
  final T1 model1;
  final T2 model2;
  final T3 model3;

  ///model创建好后会调用此方法，根据需要传入
  final Function(T1, T2, T3 model3) onModelReady;

  const Provider3Widget({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    @required this.model3,
    this.onModelReady,
  }) : super(key: key);

  _Provider3WidgetState<T1, T2, T3> createState() =>
      _Provider3WidgetState<T1, T2, T3>();
}

class _Provider3WidgetState<T1 extends ViewModel, T2 extends ViewModel,
    T3 extends ViewModel> extends State<Provider3Widget<T1, T2, T3>> {
  @override
  void initState() {
    //开始加载数据
    if (widget.onModelReady != null) {
      widget.onModelReady(widget.model1, widget.model2, widget.model3);
    } else {
      widget.model1.initData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<T1>(
          create: (BuildContext context) => widget.model1,
        ),
        ChangeNotifierProvider<T2>(
          create: (BuildContext context) => widget.model2,
        ),
        ChangeNotifierProvider<T3>(
          create: (BuildContext context) => widget.model3,
        ),
      ],
      child: Builder(
        builder: (BuildContext c) {
          return widget.builder(c);
        },
      ),
    );
  }
}

class Provider4Widget<T1 extends ViewModel, T2 extends ViewModel,
    T3 extends ViewModel, T4 extends ViewModel> extends StatefulWidget {
  final Widget Function(
      BuildContext context) builder;

  ///根据model状态构建页面
  final T1 model1;
  final T2 model2;
  final T3 model3;
  final T4 model4;

  ///model创建好后会调用此方法，根据需要传入
  final void Function(T1, T2, T3, T4) onModelReady;

  const Provider4Widget({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    @required this.model3,
    @required this.model4,
    this.onModelReady,
  }) : super(key: key);

  _Provider4WidgetState<T1, T2, T3, T4> createState() =>
      _Provider4WidgetState<T1, T2, T3, T4>();
}

class _Provider4WidgetState<
    T1 extends ViewModel,
    T2 extends ViewModel,
    T3 extends ViewModel,
    T4 extends ViewModel> extends State<Provider4Widget<T1, T2, T3, T4>> {
  @override
  void initState() {
    //开始加载数据
    if (widget.onModelReady != null) {
      widget.onModelReady(
          widget.model1, widget.model2, widget.model3, widget.model4);
    }else {
      widget.model1.initData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<T1>(
          create: (BuildContext context) => widget.model1,
        ),
        ChangeNotifierProvider<T2>(
          create: (BuildContext context) => widget.model2,
        ),
        ChangeNotifierProvider<T3>(
          create: (BuildContext context) => widget.model3,
        ),
        ChangeNotifierProvider<T4>(
          create: (BuildContext context) => widget.model4,
        ),
      ],
      child: Builder(
        builder: (BuildContext c) {
          return widget.builder(c);
        },
      ),
    );
  }
}

//加载框
class CircleProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 20,
        height: 20,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
