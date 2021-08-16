import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

/// @author jd

class CustomSliverWidget extends SingleChildRenderObjectWidget {
  const CustomSliverWidget({Key key, Widget child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => CustomSliver();
}

class CustomSliver extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    final SliverConstraints constraints = this.constraints;
    final bool active = constraints.overlap < 0.0;
    //头部滑动的距离
    final double overscrolledExtent =
        constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;

    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double layoutExtent = child.size.height;
    print('layoutExtent = $layoutExtent');
    child.layout(
        constraints.asBoxConstraints(
            maxExtent: layoutExtent + overscrolledExtent),
        parentUsesSize: true);
    if (active) {
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintOrigin: min(overscrolledExtent - layoutExtent, 0),
        paintExtent: max(max(child.size.height, layoutExtent), 0.0),
        maxPaintExtent: max(max(child.size.height, layoutExtent), 0.0),
        layoutExtent: min(overscrolledExtent, layoutExtent),
      );
    } else {
      geometry = SliverGeometry.zero;
      // geometry = SliverGeometry(
      //   scrollExtent: layoutExtent,
      //   paintOrigin: 0,
      //   visible: true,
      //   paintExtent: layoutExtent,
      //   maxPaintExtent: layoutExtent,
      //   layoutExtent: layoutExtent,
      // );
    }
    setChildParentData(child, constraints, geometry);
  }
}
