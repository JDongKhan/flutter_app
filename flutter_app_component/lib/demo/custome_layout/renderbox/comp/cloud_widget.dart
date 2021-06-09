import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class CloudWidget extends MultiChildRenderObjectWidget {
  final Overflow overflow;
  final double ratio;

  CloudWidget(
      {Key key,
      this.ratio,
      this.overflow = Overflow.clip,
      List<Widget> children = const <Widget>[]})
      : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCloudRenderBox(
      ratio: ratio,
      overflow: overflow,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCloudRenderBox renderObject) {
    renderObject
      ..ratio = ratio
      ..overflow = overflow;
  }
}

class RenderCloudParentData extends ContainerBoxParentData<RenderBox> {
  double width;
  double height;
  Rect get content => Rect.fromLTRB(offset.dx, offset.dy, width, height);
}

class RenderCloudRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, RenderCloudParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, RenderCloudParentData> {
  Overflow _overflow;
  double _ratio;
  bool _needClip;

  set ratio(v) => _ratio = v;
  get ratio => _ratio;

  set overflow(v) => _overflow = v;
  get overflow => _overflow;

  RenderCloudRenderBox({
    List<RenderBox> children,
    Overflow overflow = Overflow.visible,
    double ratio,
  })  : _ratio = ratio,
        _overflow = overflow {
    addAll(children);
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! RenderCloudParentData) {
      child.parentData = RenderCloudParentData();
    }
  }

  @override
  void performLayout() {
    //默认不需裁剪
    _needClip = false;
    //没有 childcount 则返回
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    //初始化
    var recordRect = Rect.zero;
    var previousChildRect = Rect.zero;

    RenderBox child = firstChild;

    while (child != null) {
      var curIndex = -1;
      //提取数据
      final RenderCloudParentData childParentData = child.parentData;
      child.layout(constraints, parentUsesSize: true);
      var childSize = child.size;
      //记录大小
      childParentData.width = childSize.width;
      childParentData.height = childSize.height;

      do {
        //设置 xy轴的比例
        var rX = _ratio >= 1 ? _ratio : 1.0;
        var rY = _ratio <= 1 ? _ratio : 1.0;
        //调整位置
        var step = 0.02 * pi;
        var rotation = 0.0;
        var angle = curIndex * step;
        var angleRadius = 5 + 5 * angle;
        var x = rX * angleRadius * cos(angle + rotation);
        var y = rY * angleRadius * sin(angle + rotation);
        var position = Offset(x, y);

        //计算得到绝对偏移
        var childOffset = position - Alignment.center.alongSize(childSize);
        ++curIndex;
        //设置为遏制
        childParentData.offset = childOffset;
        //判断是否交叠
      } while (overlaps(childParentData));

      //记录区域
      previousChildRect = childParentData.content;
      recordRect = recordRect.expandToInclude(previousChildRect);
      //下一个
      child = childParentData.nextSibling;
    }

    //调整布局大小
    size = constraints
        .tighten(
          height: recordRect.height,
          width: recordRect.width,
        )
        .smallest;
    //居中
    var contentCenter = size.center(Offset.zero);
    var recordRectCenter = recordRect.center;
    var transCenter = contentCenter - recordRectCenter;
    child = firstChild;
    while (child != null) {
      final RenderCloudParentData childParentData = child.parentData;
      childParentData.offset += transCenter;
      child = childParentData.nextSibling;
    }
    //判断是否超过
    _needClip =
        size.width < recordRect.width || size.height < recordRect.height;

    super.performLayout();
  }

  bool overlaps(RenderCloudParentData childParentData) {}
}
