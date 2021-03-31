import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/**
 *
 * @author jd
 *
 */

class CustomRefreshWidget extends SingleChildRenderObjectWidget {
  const CustomRefreshWidget({Key key, Widget child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SimpleRefreshSliver();
  }
}

/// 一个简单的下拉刷新 Widget
class SimpleRefreshSliver extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        childExtent = child.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    final bool active = constraints.overlap < 0.0;
    final double overscrolledExtent =
        constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;
    double layoutExtent = child.size.height;
    print("overscrolledExtent:${overscrolledExtent - layoutExtent}");
    child.layout(
      constraints.asBoxConstraints(
        maxExtent: layoutExtent
            // Plus only the overscrolled portion immediately preceding this
            // sliver.
            +
            overscrolledExtent,
      ),
      parentUsesSize: true,
    );
    if (active) {
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,

        /// 绘制起始位置
        paintOrigin: min(overscrolledExtent - layoutExtent, 0),
        paintExtent: max(
          max(child.size.height, layoutExtent),
          0.0,
        ),
        maxPaintExtent: max(
          max(child.size.height, layoutExtent),
          0.0,
        ),

        /// 布局占位
        layoutExtent: min(overscrolledExtent, layoutExtent),
      );
    } else {
      /// 如果不想显示可以直接设置为 zero
      geometry = SliverGeometry.zero;
    }
    setChildParentData(child, constraints, geometry);
  }
}
