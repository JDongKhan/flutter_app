import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';

class JDButton extends StatelessWidget {
  const JDButton({
    Key key,
    this.action,
    this.icon,
    this.text,
    this.backgroundImage,
    this.width,
    this.height,
    this.middlePadding = 2.0,
    this.padding = const EdgeInsets.all(5),
    this.margin = const EdgeInsets.all(0),
    this.backgroundColor = Colors.transparent,
    this.imageDirection = AxisDirection.up,
  }) : super(key: key);

  final Icon icon;
  final double middlePadding;
  final action;
  final Text text;
  final String backgroundImage;
  final AxisDirection imageDirection;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = icon;
    Widget textWidget = text;

    double _kpPadding = this.middlePadding;
    const double _bPadding = 2;
    Widget layoutWidget;
    List<Widget> childList = [];
    if (imageDirection == AxisDirection.up) {
      if (imageWidget != null) childList.add(imageWidget);
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: _kpPadding,
            bottom: _bPadding,
          ),
        ));
      }
      layoutWidget = Column(
        mainAxisSize:MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: childList,
      );
    } else if (imageDirection == AxisDirection.down) {
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            top: _bPadding,
            bottom: _kpPadding,
          ),
        ));
      }
      if (imageWidget != null) childList.add(imageWidget);
      layoutWidget = Column(
        mainAxisSize:MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: childList,
      );
    } else if (imageDirection == AxisDirection.left) {
      if (imageWidget != null) childList.add(imageWidget);
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: EdgeInsets.only(
            left: _kpPadding,
            right: _bPadding,
            top: 0,
            bottom: 0,
          ),
        ));
      }

      layoutWidget = Row(
        mainAxisSize:MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: childList,
      );
    } else if (imageDirection == AxisDirection.right) {
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: EdgeInsets.only(
            left: _bPadding,
            right: _kpPadding,
            top: 0,
            bottom: 0,
          ),
        ));
      }
      if (imageWidget != null) childList.add(imageWidget);

      layoutWidget = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize:MainAxisSize.min,
        children: childList,
      );
    }

    //背景颜色
    BoxDecoration boxDecoration = null;
    if (backgroundImage != null) {
      boxDecoration = BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(JDAssetBundle.getImgPath(backgroundImage)),
          fit: BoxFit.cover,
        ),
      );
    }

    layoutWidget = Container(
      width: width,
      height: height,
      color: backgroundColor,
      decoration: boxDecoration,
      padding: padding,
      margin: margin,
      child: layoutWidget,
    );
    if (action!= null) {
      layoutWidget = GestureDetector(
        onTap: () {
          if (action!= null) action();
        },
        child: layoutWidget,
      );
    }

    return layoutWidget;
  }
}
