import 'package:flutter/material.dart';

/// @author jd
///

typedef RebuildFuncation<T> = bool Function(T oldWidget, T newWidget);

///重建widget
class RebuildWidget<T extends Widget> extends StatefulWidget {
  const RebuildWidget({
    Key key,
    @required this.child,
    @required this.rebuild,
  }) : super(key: key);
  final Widget child;
  final RebuildFuncation rebuild;

  @override
  _RebuildWidgetState<T> createState() => _RebuildWidgetState<T>();
}

class _RebuildWidgetState<T extends Widget> extends State<RebuildWidget> {
  RebuildWidget get widget => super.widget;
  T oldWidget;

  @override
  Widget build(BuildContext context) {
    final T newWidget = widget.child;
    if ((oldWidget == null) ||
        (widget.rebuild == null
            ? true
            : widget.rebuild(oldWidget, newWidget))) {
      oldWidget = newWidget;
    }
    return oldWidget;
  }
}
