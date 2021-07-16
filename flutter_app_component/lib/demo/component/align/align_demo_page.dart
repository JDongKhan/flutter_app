import 'dart:math' as math;

import 'package:flutter/material.dart';

class AlignDemoPage extends StatefulWidget {
  @override
  _AlignDemoPageState createState() => _AlignDemoPageState();
}

class _AlignDemoPageState extends State<AlignDemoPage>
    with SingleTickerProviderStateMixin {
  getAlign(x) {
    return Align(
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      alignment: Alignment(math.cos(x * math.pi), math.sin(x * math.pi)),
    );
  }

  @override
  Widget build(BuildContext context) {
    int size = 20;
    return Scaffold(
      appBar: AppBar(
        title: Text("AlignDemoPage"),
      ),
      body: Container(
        alignment: Alignment(0, 0),
        child: Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: List.generate(size, (index) {
              return getAlign(index.toDouble() / size / 2);
            }),
          ),
        ),
      ),
    );
  }
}
