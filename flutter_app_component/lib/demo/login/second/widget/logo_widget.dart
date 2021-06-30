import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

class LogoWidget extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<LogoWidget> with SingleTickerProviderStateMixin {
  final List<Widget> list = [];
  Timer timer;
  Image logo;

  @override
  void initState() {
    logo = Image.asset(
      JDAssetBundle.getIconPath('logo'),
      width: jd_getWidth(150),
      height: jd_getWidth(150),
    );
    super.initState();

    list.add(logo);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initTimer();
    });
  }

  void initTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        ///理论上讲 第二个总是先完成的
        list.add(WaveWidget((index) {
          list.removeAt(1);
        }));
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: jd_getWidth(500),
      height: jd_getWidth(400),
      child: Stack(
        alignment: Alignment.center,
        children: list,
      ),
    );
  }
}

typedef AnimationCallback = void Function(int index);

class WaveWidget extends StatefulWidget {
  final AnimationCallback animateDone;
  WaveWidget(this.animateDone);

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation first;

  double opacity = 0.8;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    first = Tween<double>(begin: jd_getWidth(180), end: jd_getWidth(360))
        .animate(controller);
    super.initState();
//
//    controller.addStatusListener((status) {
//      if(status == AnimationStatus.completed){
//
//      }
//    });
    first.addListener(() {
      opacity = (1 - first.value / jd_getWidth(360)).clamp(0.0, 1.0);
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: first.value,
      height: first.value,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white.withOpacity(opacity), width: jd_getWidth(2))),
    );
  }
}
