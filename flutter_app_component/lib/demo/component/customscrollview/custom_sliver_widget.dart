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
    //将SliverConstraints转化为BoxConstraints ，对child进行layout
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    //计算绘制大小
    // final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    //计算缓存大小
  }
}
