import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

//弹框菜单， 朋友圈使用
void showPopMenu({
  BuildContext context,

  //context + alignment 组合使用
  Widget child,
  Alignment alignment = Alignment.topRight,
  Offset offset = Offset.zero,

  //left,top,right,bottom单独使用
  double left,
  double top,
  double right,
  double bottom,
}) {
  Navigator.push(
    context,
    PopRoute(
      targetContext: context,
      alignment: alignment,
      child: child,
      offset: offset,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
  );
}

class PopRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 300);

  PopRoute({
    @required this.child,
    //targetContext + alignment 组合使用
    this.targetContext,
    this.alignment,
    this.offset = Offset.zero,
    //left,top,right,bottom单独使用
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  final Widget child;
  final double left; //距离左边位置
  final double top; //距离上面位置
  final double right; //距离上面位置
  final double bottom; //距离上面位置
  final Alignment alignment;
  final BuildContext targetContext;
  final Offset offset; //偏移量

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    double left = this.left;
    double top = this.top;
    double right = this.right;
    double bottom = this.bottom;
    double axisAlignment = 0;
    if (targetContext != null) {
      RenderBox box = targetContext.findRenderObject() as RenderBox;
      Rect frame = box.localToGlobal(Offset.zero) & box.size;
      left = null;
      top = null;
      right = null;
      bottom = null;
      double right1 = jd_screenWidth() - frame.left;
      if (alignment == Alignment.topLeft) {
        top = frame.top + offset?.dy;
        right = right1 + offset?.dx;
        axisAlignment = 1;
      } else if (alignment == Alignment.topCenter) {
        top = frame.top + offset?.dy;
        left = frame.right - box.size.width / 2 + offset?.dx;
      } else if (alignment == Alignment.topRight) {
        top = frame.top + offset?.dy;
        left = frame.right + offset?.dx;
      } else if (alignment == Alignment.centerLeft) {
        top = frame.top + box.size.height / 2 + offset?.dy;
        right = right1 + offset?.dx;
      } else if (alignment == Alignment.center) {
        top = frame.top + box.size.height / 2 + offset?.dy;
        left = frame.right - box.size.width / 2 + offset?.dx;
      } else if (alignment == Alignment.centerRight) {
        top = frame.top + box.size.height / 2 + offset?.dy;
        left = frame.right + offset?.dx;
      } else if (alignment == Alignment.bottomLeft) {
        top = frame.bottom + offset?.dy;
        left = right1 + offset?.dx;
      } else if (alignment == Alignment.bottomCenter) {
        top = frame.bottom + offset?.dy;
        left = frame.right - box.size.width / 2 + offset?.dx;
      } else if (alignment == Alignment.bottomRight) {
        top = frame.bottom + offset?.dy;
        left = frame.right + offset?.dx;
      }
    }
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          Navigator.of(context).pop();
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Positioned(
              child: FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: axisAlignment,
                  axis: Axis.horizontal,
                  child: child,
                ),
              ),
              left: left,
              top: top,
              right: right,
              bottom: bottom,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => _duration;
}
