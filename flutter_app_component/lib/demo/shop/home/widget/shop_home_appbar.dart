import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class ShopHomeAppBar extends StatefulWidget {
  const ShopHomeAppBar({
    Key key,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.brightness,
    this.centerTitle,
    this.collapsedHeight,
    this.expandedHeight,
    this.titleSpacing = 0,
  }) : super(key: key);

  final Widget leading;

  final Widget title;

  final List<Widget> actions;

  final PreferredSizeWidget bottom;

  final Color backgroundColor;

  final Brightness brightness;

  final bool centerTitle;

  final double collapsedHeight;

  final double expandedHeight;

  final double titleSpacing;

  @override
  _ShopHomeAppBarState createState() => _ShopHomeAppBarState();
}

class _ShopHomeAppBarState extends State<ShopHomeAppBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double collapsedHeight =
        widget.collapsedHeight ?? kToolbarHeight + topPadding;

    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: _ShopHomeSliverAppBarDelegate(
        vsync: this,
        leading: widget.leading,
        title: widget.title,
        actions: widget.actions,
        bottom: widget.bottom,
        backgroundColor: widget.backgroundColor,
        brightness: widget.brightness,
        expandedHeight: widget.expandedHeight,
        collapsedHeight: collapsedHeight,
        topPadding: topPadding,
        titleSpacing: widget.titleSpacing,
        centerTitle: widget.centerTitle,
      ),
    );
  }
}

class _ShopHomeSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _ShopHomeSliverAppBarDelegate({
    @required this.leading,
    @required this.title,
    @required this.actions,
    @required this.bottom,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.brightness,
    @required this.expandedHeight,
    @required this.collapsedHeight,
    @required this.topPadding,
    @required this.vsync,
    @required this.titleSpacing,
    this.centerTitle,
  }) : _bottomHeight = bottom?.preferredSize?.height ?? 0.0;

  final Widget leading;
  final Widget title;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Color backgroundColor;
  final Color foregroundColor;
  final Brightness brightness;
  final double expandedHeight;
  final double collapsedHeight;
  final double topPadding;
  final double titleSpacing;
  final double _bottomHeight;
  final bool centerTitle;

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => math.max(expandedHeight ?? kToolbarHeight, minExtent);

  @override
  final TickerProvider vsync;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double variableExtent = maxExtent - kToolbarHeight; //可变最大范围
    final double variableHeight =
        maxExtent - shrinkOffset - kToolbarHeight; //变化的高度
    double alpha = variableHeight / variableExtent; //计算百分比
    // print('$variableHeight - $shrinkOffset -$alpha');
    alpha = alpha.clamp(0, 1).toDouble(); //取安全范围值
    double botton_right =
        (1 - alpha) * 40 * actions.length; //计算右侧按钮宽度，暂时一个按钮为40

    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(opacity: alpha, child: leading ?? Container()),
                    Expanded(
                      child: Opacity(
                        opacity: alpha,
                        child: Container(
                          alignment: centerTitle
                              ? Alignment.center
                              : Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              left: leading != null ? titleSpacing : 10),
                          child: title,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: botton_right,
                child: Container(child: bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _ShopHomeSliverAppBarDelegate oldDelegate) {
    return leading != oldDelegate.leading ||
        title != oldDelegate.title ||
        actions != oldDelegate.actions ||
        bottom != oldDelegate.bottom ||
        _bottomHeight != oldDelegate._bottomHeight ||
        backgroundColor != oldDelegate.backgroundColor ||
        brightness != oldDelegate.brightness ||
        expandedHeight != oldDelegate.expandedHeight ||
        topPadding != oldDelegate.topPadding ||
        vsync != oldDelegate.vsync ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        stretchConfiguration != oldDelegate.stretchConfiguration ||
        showOnScreenConfiguration != oldDelegate.showOnScreenConfiguration ||
        titleSpacing != oldDelegate.titleSpacing;
  }

  @override
  String toString() {
    return '${describeIdentity(this)}(topPadding: ${topPadding.toStringAsFixed(1)}, bottomHeight: ${_bottomHeight.toStringAsFixed(1)}, ...)';
  }
}
