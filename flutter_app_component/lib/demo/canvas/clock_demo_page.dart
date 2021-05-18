import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './clock/clock_view.dart';
import './clock/grid_line.dart';
import './clock/star_view.dart';

/// @author jd

class ClockDemoPage extends StatefulWidget {
  @override
  _ClockDemoPageState createState() => _ClockDemoPageState();
}

class _ClockDemoPageState extends State<ClockDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock Demo'),
      ),
      body: Column(
        children: [
          CustomPaint(
            painter: GridLine(context),
          ),
          CustomPaint(
            painter: ClockView(),
          ),
          CustomPaint(
            painter: StarView(),
          ),
        ],
      ),
    );
  }
}
