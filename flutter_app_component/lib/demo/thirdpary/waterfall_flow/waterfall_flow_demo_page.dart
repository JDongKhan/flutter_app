import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// @author jd
class WaterfallFlowDemoPage extends StatefulWidget {
  @override
  _WaterfallFlowDemoPageState createState() => _WaterfallFlowDemoPageState();
}

class _WaterfallFlowDemoPageState extends State<WaterfallFlowDemoPage> {
  List _list;

  @override
  void initState() {
    _list = List.generate(50, (index) => '$index').toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WaterfallFlowDemoPage'),
      ),
      body: WaterfallFlow.builder(
        itemCount: _list.length,
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          lastChildLayoutTypeBuilder: (int index) => index == _list.length
              ? LastChildLayoutType.foot
              : LastChildLayoutType.none,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.red,
            child: Center(child: Text('${_list[index]}')),
            height: Random().nextDouble() * 50 + 100,
          );
        },
      ),
    );
  }
}
