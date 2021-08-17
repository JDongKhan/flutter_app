import 'package:flutter/cupertino.dart';

/// @author jd

class CustomBouncingScrollPhysics extends BouncingScrollPhysics {
  const CustomBouncingScrollPhysics({ScrollPhysics parent})
      : super(parent: parent);

  @override
  CustomBouncingScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      //underscroll
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      //hit top edg
      return value - position.minScrollExtent;
    }
    return 0.0;
    // return super.applyBoundaryConditions(position, value);
  }
}
