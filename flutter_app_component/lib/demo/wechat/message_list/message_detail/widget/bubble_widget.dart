import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

const double _ArrowWidth = 7.0; //箭头宽度
const double _ArrowHeight = 10.0; //箭头高度
const double _MinHeight = 32.0; //内容最小高度
const double _MinWidth = 50.0; //内容最小宽度

///方向
enum BubbleDirection { left, right }

class BubbleWidget extends StatelessWidget {
  const BubbleWidget({
    Key key,
    this.direction = BubbleDirection.left,
    this.borderRadius = const Radius.circular(5.0),
    this.child,
    this.decoration,
    this.color = Colors.orange,
    this.padding,
    this.margin,
    this.constraints,
    this.width,
    this.height,
    this.alignment,
  })  : _left = direction == BubbleDirection.left ? _ArrowWidth : 0.0,
        _right = direction == BubbleDirection.right ? _ArrowWidth : 0.0,
        super(key: key);

  final BubbleDirection direction;
  final Radius borderRadius;
  final Widget child;
  final BoxDecoration decoration;
  final Color color;
  final double _left;
  final double _right;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxConstraints constraints;
  final double width;
  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper:
          _BubbleClipper(direction, borderRadius ?? const Radius.circular(5.0)),
      child: Container(
        alignment: alignment,
        width: width,
        height: height,
        constraints: (constraints ?? const BoxConstraints())
            .copyWith(minHeight: _MinHeight, minWidth: _MinWidth),
        margin: margin,
        decoration: decoration,
        color: color,
        padding: EdgeInsets.fromLTRB(_left, 0.0, _right, 0.0)
            .add(padding ?? const EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 5.0)),
        child: child,
      ),
    );
  }
}

class _BubbleClipper extends CustomClipper<Path> {
  _BubbleClipper(this.direction, this.radius);

  final BubbleDirection direction;
  final Radius radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final Path path2 = Path();
    final double centerPoint =
        (size.height / 2).clamp(_MinHeight / 2, _MinHeight / 2);
    print(centerPoint);
    if (direction == BubbleDirection.left) {
      //绘制左边三角形
      path.moveTo(0, centerPoint);
      path.lineTo(_ArrowWidth, centerPoint - _ArrowHeight / 2);
      path.lineTo(_ArrowWidth, centerPoint + _ArrowHeight / 2);
      path.close();
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(_ArrowWidth, 0, size.width - _ArrowWidth, size.height),
          radius));
      //合并
      path.addPath(path2, const Offset(0, 0));
    } else {
      //绘制右边三角形
      path.moveTo(size.width, centerPoint);
      path.lineTo(size.width - _ArrowWidth, centerPoint - _ArrowHeight / 2);
      path.lineTo(size.width - _ArrowWidth, centerPoint + _ArrowHeight / 2);
      path.close();
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width - _ArrowWidth, size.height), radius));
      //合并
      path.addPath(path2, const Offset(0, 0));
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
