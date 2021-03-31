import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';

class JDButton extends StatelessWidget {
  const JDButton({
    Key key,
    this.action,
    this.icon,
    this.title,
    this.text,
    this.backgroundImage,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(5),
    this.margin = const EdgeInsets.all(0),
    this.backgroundColor = Colors.blue,
    this.imageDirection = AxisDirection.up,
  }) : super(key: key);

  final Icon icon;
  final action;
  final String title;
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
    Widget imageWidget = null;
    if (icon != null) {
      imageWidget = Container(
        child: icon,
      );
    }

    Widget textWidget = text;

    const double _kpPadding = 2;
    const double _bPadding = 2;
    Widget layoutWidget;
    List<Widget> childList = [];
    if (imageDirection == AxisDirection.up) {
      if (imageWidget != null) childList.add(imageWidget);
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: _kpPadding,
            bottom: _bPadding,
          ),
        ));
      }
      layoutWidget = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: childList,
      );
    } else if (imageDirection == AxisDirection.down) {
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
            top: _bPadding,
            bottom: _kpPadding,
          ),
        ));
      }
      if (imageWidget != null) childList.add(imageWidget);
      layoutWidget = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: childList,
      );
    } else if (imageDirection == AxisDirection.left) {
      if (imageWidget != null) childList.add(imageWidget);
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: const EdgeInsets.only(
            left: _kpPadding,
            right: _bPadding,
            top: 0,
            bottom: 0,
          ),
        ));
      }

      layoutWidget = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: childList,
      );
    } else if (imageDirection == AxisDirection.right) {
      if (text != null) {
        childList.add(Container(
          child: textWidget,
          padding: const EdgeInsets.only(
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

    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        width: width,
        height: height,
        color: backgroundColor,
        decoration: boxDecoration,
        padding: padding,
        margin: margin,
        child: layoutWidget,
      ),
    );
  }
}
