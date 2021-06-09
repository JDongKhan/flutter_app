import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class Animal1Page extends StatefulWidget {
  @override
  _Animal1PageState createState() => _Animal1PageState();
}

class _Animal1PageState extends State<Animal1Page> {
  double width = 200;
  double height = 100;
  double padding = 10;
  Color color = Colors.blueAccent;
  Alignment alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal 1'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            // transformAlignment: Alignment.topLeft,
            duration: const Duration(milliseconds: 500),
            width: width,
            height: height,
            padding: EdgeInsets.all(padding),
            color: color,
            alignment: alignment,
            child: const Text(
              'Animal 1',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(padding),
            color: color,
            alignment: alignment,
            child: const Text(
              'Animal 1',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              play();
            },
            child: Text('Play'),
          ),
        ],
      ),
    );
  }

  void play() {
    var width = Random.secure().nextInt(150);
    var height = Random.secure().nextInt(100);
    this.width = width.toDouble() + 200;
    this.height = height.toDouble() + 100;
    setState(() {});
  }
}
