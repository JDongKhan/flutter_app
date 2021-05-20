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
  final Function(T) onModelReady;

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
  T model;

  @override
  void initState() {
    model = widget.model;
    //开始加载数据
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
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
          Widget child = null;
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

class ProvidersWidget extends StatefulWidget {
  final Widget Function(BuildContext context, List<ChangeNotifier> models)
      builder;

  ///根据model状态构建页面
  final List<ChangeNotifier> models;

  ///此child 为stateless 可以视具体情况使用（一般用不到）
  final Function(List<ChangeNotifier> models) onModelReady;

  ///model创建好后会调用此方法，根据需要传入

  const ProvidersWidget({
    Key key,
    @required this.builder,
    @required this.models,
    this.onModelReady,
  }) : super(key: key);

  _ProvidersWidgetState createState() => _ProvidersWidgetState();
}

class _ProvidersWidgetState extends State<ProvidersWidget> {
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(widget.models);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: widget.models
          .map(
            (e) => ChangeNotifierProvider<ChangeNotifier>(
              create: (BuildContext context) => e,
            ),
          )
          .toList(),
      child: Builder(
        builder: (BuildContext c) {
          return widget.builder(context, widget.models);
        },
      ),
    );
  }
}

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
