import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @author jd
///
///


/// 矩形高斯模糊效果
class BlurRectWidget extends StatefulWidget {

  const BlurRectWidget({
    Key key,
    this.child,
    this.sigmaX,
    this.sigmaY,
    this.opacity,
    this.blurMargin = EdgeInsets.zero,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;

  /// 模糊值
  final double sigmaX;
  final double sigmaY;

  /// 透明度
  final double opacity;

  /// 外边距
  final EdgeInsetsGeometry blurMargin;

  /// 圆角
  final BorderRadius borderRadius;

  @override
  _BlurRectWidgetState createState() => _BlurRectWidgetState();
}

class _BlurRectWidgetState extends State<BlurRectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.blurMargin ?? EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? const BorderRadius.only(topLeft:  Radius.circular(10), topRight: Radius.circular(10)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.sigmaX ?? 10,
            sigmaY: widget.sigmaY ?? 10,
          ),
          child: Container(
            color: Colors.white10,
            child: widget.opacity != null ? Opacity(opacity: widget.opacity, child: widget.child,) : widget.child,
          ),
        ),
      ),
    );
  }
}