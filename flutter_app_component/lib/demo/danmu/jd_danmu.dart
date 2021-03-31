import 'package:flutter/material.dart';

class JDDanMu extends StatefulWidget {
  @override
  _JDDanMuState createState() => _JDDanMuState();
}

class _JDDanMuState extends State<JDDanMu> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(duration: Duration(seconds: 5),vsync: this)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed) {
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("弹幕"),),
      body: Container(),
    );
  }
}
