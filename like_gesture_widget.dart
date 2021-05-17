import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class LikeGestureWidget extends StatefulWidget {
  const LikeGestureWidget({
    Key key,
    @required this.child,
    this.onAddFavorite,
    this.onSingleTap,
  }) : super(key: key);

  final Function onAddFavorite; //添加爱心的回调
  final Function onSingleTap; //单击的回调
  final Widget child; //子部件

  @override
  _LikeGestureWidgetState createState() => _LikeGestureWidgetState();
}

class _LikeGestureWidgetState extends State<LikeGestureWidget> {
  GlobalKey _key = GlobalKey(); //用于位置的计算
  List<Offset> icons = []; //存储点击位置
  int lastMilliSeconds = -1; //记录上次手指抬起的时间毫秒值

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTapDown: (detail) {
        setState(() {
          //获取当前时间的毫秒值
          int currentMilliSeconds = DateTime.now().millisecondsSinceEpoch;
          //计算当前时间毫秒值与上次抬起时间的差值
          int diff = currentMilliSeconds - lastMilliSeconds;
          //如果差值小于500毫秒，就向列表中添加此时手指点击的位置，如果大于500毫秒就是单击事件
          if (diff < 500) {
            icons.add(_convertPosition(detail.globalPosition));
            widget.onAddFavorite?.call();
          } else {
            widget.onSingleTap?.call();
          }
        });
      },
      onTapUp: (detail) {
        //手指抬起时的时间毫秒值
        lastMilliSeconds = DateTime.now().millisecondsSinceEpoch;
      },
      child: Stack(
        children: <Widget>[
          //外部的部件，至于动画的下面
          widget.child,
          //小红心动画效果
          _getIconStack(),
        ],
      ),
    );
  }

  // 将给定的点从逻辑像素的全局坐标系统转换为此部件的局部坐标系统。
  Offset _convertPosition(Offset p) {
    RenderBox getBox = _key.currentContext.findRenderObject() as RenderBox;
    return getBox.globalToLocal(p);
  }

  _getIconStack() {
    return Stack(
      children: icons
          .map<Widget>(
            (position) => TikTokFavoriteAnimationIcon(
              key: Key(position.toString()),
              position: position,
              onAnimationStart: () {
                icons.remove(position);
              },
            ),
          )
          .toList(),
    );
  }
}

class TikTokFavoriteAnimationIcon extends StatefulWidget {
  final Offset position; //位置
  final double size; //图标大小
  final Function onAnimationStart; //动画开始的回调

  const TikTokFavoriteAnimationIcon({
    Key key,
    this.onAnimationStart,
    this.position,
    this.size: 160,
  }) : super(key: key);

  @override
  _TikTokFavoriteAnimationIconState createState() =>
      _TikTokFavoriteAnimationIconState();
}

class _TikTokFavoriteAnimationIconState
    extends State<TikTokFavoriteAnimationIcon>
    with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController _animationController;
  //图标的旋转角度，随机
  double rotate = pi / 10.0 * (2 * Random().nextDouble() - 1);

  @override
  void initState() {
    _animationController = AnimationController(
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animationController.addListener(() {
      setState(() {});
    });
    startAnimation();
    super.initState();
  }

  //开始动画,动画一执行，就从列表里删除动画对应的位置
  startAnimation() async {
    await _animationController.forward();
    widget.onAnimationStart.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.position == null
        ? Container()
        : Positioned(
            left: widget.position.dx - widget.size / 2,
            top: widget.position.dy - widget.size,
            child: _getBody(),
          );
  }

  _getBody() {
    return Transform.rotate(
      angle: rotate,
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: _getContent(),
        ),
      ),
    );
  }

  //获取动画的值
  double get value => _animationController.value;

  //获取动画的不透明度
  double get opacity {
    if (value < 0.1) {
      return 0.9 / 0.1 * value;
    }
    if (value < 0.8) {
      return 0.9;
    }
    var res = 0.9 - (value - 0.8) / (1 - 0.8);
    return res < 0 ? 0 : res;
  }

  //获取动画的缩放比例
  double get scale {
    if (value <= 0.5) {
      return 0.6 + value / 0.5 * 0.5;
    } else if (value <= 0.8) {
      return 1.1 * (1 / 1.1 + (1.1 - 1) / 1.1 * (value - 0.8) / 0.25);
    } else {
      return 1 + (value - 0.8) / 0.2 * 0.5;
    }
  }

  _getContent() {
    return ShaderMask(
      child: _getChild(),
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => RadialGradient(
        center: Alignment.topLeft.add(Alignment(0.5, 0.5)),
        colors: [
          Color(0xffEF6F6F),
          Color(0xffF03E3E),
        ],
      ).createShader(bounds),
    );
  }

  //图标
  _getChild() {
    return Icon(
      Icons.favorite_rounded,
      size: widget.size,
    );
  }
}
