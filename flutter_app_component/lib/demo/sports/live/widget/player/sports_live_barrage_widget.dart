import 'dart:math';

import 'package:flutter/material.dart';

/// @author jd
class SportsLiveBarrageWidget extends StatefulWidget {
  @override
  _SportsLiveBarrageWidgetState createState() =>
      _SportsLiveBarrageWidgetState();
}

class _SportsLiveBarrageWidgetState extends State<SportsLiveBarrageWidget> {
  List<_BarrageItem> _allText = [];

  double _width, _height;

  int _barrageIndex = 0;
  int _lastIndex = 0;

  @override
  void initState() {
    _start();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //添加弹幕
  void _start() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        debugPrint("显示");
        _insert();
        _start();
      } else {
        debugPrint("不显示");
      }
    });
  }

  void _insert() {
    String id = '${DateTime.now().toIso8601String()}:${Random().nextInt(1000)}';
    _allText.add(_BarrageItem(
      key: ValueKey<String>(id),
      top: _randomComputeTop(),
      text: '我是一条闲鱼',
      onComplete: (e) {
        _allText.remove(e);
      },
    ));
    _barrageIndex++;
    setState(() {});
  }

  double _randomComputeTop() {
    //最大行数
    int numOfLine = 10;
    //只显示的行数
    int showLine = 5;
    //行高
    double lineHeight = _height / numOfLine;

    int randomLine = 0;
    while (randomLine == _lastIndex) {
      randomLine = Random().nextInt(showLine).toInt();
    }
    _lastIndex = randomLine;
    double top = _lastIndex * lineHeight;

    // double random = Random().nextInt(200).toDouble();
    return top;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraintType) {
      _width = constraintType.maxWidth;
      _height = constraintType.maxHeight;

      //如果需要弹幕超出不显示，则可以使用ClipRRect切掉
      return ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Stack(
          children: _allText,
        ),
      );
    });
  }
}

class _BarrageItem extends StatelessWidget {
  const _BarrageItem({Key key, this.top, this.text, this.onComplete})
      : super(key: key);
  final double top;
  final String text;
  final ValueChanged<_BarrageItem> onComplete;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      right: 0,
      child: _AnimalWidget(
        onComplete: () {
          if (onComplete != null) {
            onComplete(this);
          }
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _AnimalWidget extends StatefulWidget {
  const _AnimalWidget({this.child, this.onComplete});
  final Widget child;
  final Function onComplete;
  @override
  _AnimalWidgetState createState() => _AnimalWidgetState();
}

class _AnimalWidgetState extends State<_AnimalWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onComplete != null) {
        widget.onComplete();
      }
    });
    _animation =
        Tween<Offset>(begin: const Offset(1.0, 0), end: const Offset(-1.0, 0))
            .animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
