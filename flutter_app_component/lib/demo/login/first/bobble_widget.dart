import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 定义气泡
class BobbleBean {
  //位置
  Offset position;

  //颜色
  Color color;

  //速度
  double speed;

  // 角度
  double theta;

  // 半径
  double radius;
}

class BobbleWidget extends StatefulWidget {
  const BobbleWidget(
      {Key key, this.child, this.tintColor = Colors.white, this.linearGradient})
      : super(key: key);
  final Widget child;
  final Color tintColor;
  final LinearGradient linearGradient;
  @override
  _BobbleWidgetState createState() => _BobbleWidgetState();
}

class _BobbleWidgetState extends State<BobbleWidget>
    with TickerProviderStateMixin {
  final List<BobbleBean> _list = [];

  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);

  // 运动速度控制
  final double _maxSpeed = 2.0;

  // 设置最大半径
  final double _maxRadius = 100;

  // 设置最大角度
  final double _maxTheta = 2 * pi;

  AnimationController _animationController;

  LinearGradient _linearGradient;
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 20; i++) {
      BobbleBean bean = BobbleBean();

      int a = _random.nextInt(200);
      Color c = widget.tintColor.withAlpha(a);

      bean.color = c;
      bean.position = const Offset(-1, -1);

      bean.speed = _random.nextDouble() * _maxSpeed;

      bean.radius = _random.nextDouble() * _maxRadius;
      bean.theta = _random.nextDouble() * _maxTheta;
      _list.add(bean);
    }
    //创建动画控制器 1秒
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    // 重复执行
    _animationController.repeat();

    //背景过渡色
    _linearGradient = widget.linearGradient ??
        LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlueAccent.withOpacity(0.3),
              Colors.lightBlue.withOpacity(0.3),
              Colors.blue.withOpacity(0.3),
            ]);
  }

  @override
  void dispose() {
    //销毁
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //第一部分 第一层 渐变背景
        _buildBackground(),
        //第二部分 第二层 气泡
        _buildBubble(context),
        //第三部分 高斯模糊
        _buildBlureWidget(),
        //外面的组件
        widget.child ?? Container(),
      ],
    );
  }

  //第一部分 第一层 渐变背景
  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: _linearGradient,
      ),
    );
  }

  //第二部分 第二层 气泡
  Widget _buildBubble(BuildContext context) {
    //画板
    return _BubbleAnimalWidget(
      list: _list,
      random: _random,
      animationController: _animationController,
    );
  }

  //第三部分 高斯模糊
  Widget _buildBlureWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
      child: Container(
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }
}

// ignore: must_be_immutable
class _BubbleAnimalWidget extends StatefulWidget {
  _BubbleAnimalWidget({this.list, this.random, this.animationController});
  List<BobbleBean> list;
  Random random;
  AnimationController animationController;
  @override
  _BubbleAnimalWidgetState createState() => _BubbleAnimalWidgetState();
}

class _BubbleAnimalWidgetState extends State<_BubbleAnimalWidget> {
  @override
  void initState() {
    // 执行刷新监听
    widget.animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _CustomMyPainter(
        list: widget.list,
        random: widget.random,
      ),
    );
  }
}

class _CustomMyPainter extends CustomPainter {
  _CustomMyPainter({this.list, this.random});

  List<BobbleBean> list;
  Random random;
  final Paint _paint = Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    list.forEach((element) {
      Offset newCenterOffset = _calculateXY(element.speed, element.theta);

      double dx = newCenterOffset.dx + element.position.dx;
      double dy = newCenterOffset.dx + element.position.dy;

      if (dx < 0 || dx > size.width) {
        dx = random.nextDouble() * size.width;
      }

      if (dy < 0 || dy > size.height) {
        dy = random.nextDouble() * size.height;
      }

      element.position = Offset(dx, dy);
    });

    list.forEach((element) {
      _paint.color = element.color;
      canvas.drawCircle(element.position, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset _calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }
}
