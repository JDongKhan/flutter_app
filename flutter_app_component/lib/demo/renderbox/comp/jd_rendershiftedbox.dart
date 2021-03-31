import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

//所有的renderobject 都可以继承RenderShiftedBox 或 RenderProxyBox

class JDAlignRenderBox extends RenderShiftedBox {
  JDAlignRenderBox({RenderBox child, this.alignment = Alignment.center})
      : super(child);

  Alignment alignment;

  @override
  void performLayout() {
    //子控件布局
    child.layout(
      BoxConstraints(
        minHeight: 0,
        maxHeight: constraints.maxHeight,
        minWidth: 0,
        maxWidth: constraints.maxWidth,
      ),
      parentUsesSize: true,
    );

    //通过子控件的布局来计算自己
    final BoxParentData childPaarentData = child.parentData;
    // if (alignment == Alignment.center) {
    //   childPaarentData.offset = Offset(
    //       (constraints.maxWidth - child.size.width) / 2,
    //       (constraints.maxHeight - child.size.height) / 2);
    // } else {
    //   childPaarentData.offset = Offset(0, 0);
    // }
    //确定自己的布局细节
    childPaarentData.offset = alignment.alongOffset(
        Size(constraints.maxWidth, constraints.maxHeight) - child.size);

    // super.performLayout();
    size = Size(constraints.maxWidth, constraints.maxHeight);

    // size = Size(constraints.constrainWidth(200),constraints.constrainHeight(200));
  }

  // @override
  // bool get sizedByParent => true;
// @override
//   void performResize() {
//   // size = constraints.biggest; //等同上面
//   }
}

class JDAlignWidget extends SingleChildRenderObjectWidget {
  JDAlignWidget({Widget child, this.alignment = Alignment.center})
      : super(child: child);

  Alignment alignment;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      JDAlignRenderBox(alignment: alignment);
}
