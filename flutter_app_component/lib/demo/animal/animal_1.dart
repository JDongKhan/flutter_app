import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class JDAnimal1 extends StatefulWidget {
  @override
  _JDAnimal1State createState() => _JDAnimal1State();
}

class _JDAnimal1State extends State<JDAnimal1>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation rotateAnimal;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(
        milliseconds: 2000,
      ),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 300,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
        if (animationController.status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (animationController.status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    rotateAnimal =
        Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal 1'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: animation.value,
              width: animation.value,
              child: FlutterLogo(),
            ),
            SizedBox(
              height: 50,
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext content, Widget child) {
                return Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                );
              },
              child: FlutterLogo(),
            ),
            SizedBox(
              height: 50,
            ),
            AnimatedBuilder(
              animation: rotateAnimal,
              builder: (BuildContext content, Widget child) {
                return Transform.rotate(
                  angle: rotateAnimal.value,
                  child: child,
                );
              },
              child: FlutterLogo(),
            ),
            SizedBox(
              height: 50,
            ),
            AnimatedOpacity(
              opacity: 1,
              duration: Duration(seconds: 2),
              child: Column(
                children: [
                  Text('Type: Owl'),
                  Text('Age: 31'),
                  Text('Employment: None'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
