import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class JDTouchHighlightRender extends RenderConstrainedBox {
  JDTouchHighlightRender()
      : super(additionalConstraints: const BoxConstraints.expand());

  //自身是否可进行命中检测
  @override
  bool hitTestSelf(Offset position) => true;

  final Map<int, Offset> _dots = <int, Offset>{};

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    if (event is PointerDownEvent || event is PointerMoveEvent) {
      print("pointer:${event.pointer},position:${event.position}");
      _dots[event.pointer] = event.position;
      markNeedsPaint();
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      _dots.remove(event.pointer);
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    if (child != null) {
      //子控件布局
      child.layout(
        const BoxConstraints(
          minHeight: 0,
          maxHeight: 200,
          minWidth: 0,
          maxWidth: 200,
        ),
        parentUsesSize: true,
      );
      size = Size(
          constraints.constrainWidth(200), constraints.constrainHeight(200));
    } else {
      performResize();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // context.paintChild(child, offset);
    final Canvas canvas = context.canvas;
    canvas.drawRect(offset & size, Paint()..color = const Color(0xffff0000));

    final Paint paint = Paint()..color = const Color(0xFFFFFF00);
    for (Offset point in _dots.values) canvas.drawCircle(point, 50, paint);

    super.paint(context, offset);
  }
}

class JDTouchHighlightWidget extends SingleChildRenderObjectWidget {
  JDTouchHighlightWidget({Key key, Widget child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      JDTouchHighlightRender();
}
