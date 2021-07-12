import 'package:flutter/material.dart';

import 'demo1/jd_demo_1.dart';

/// @author jd

class JDLifeCyclePage extends StatefulWidget {
  @override
  _JDLifeCyclePageState createState() => _JDLifeCyclePageState();
}

class _JDLifeCyclePageState extends State<JDLifeCyclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeCycle'),
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
              child: Text('mixin'),
              onPressed: () {
                _test1();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _test1() {
    JDDemo1 demo1 = JDDemo1();
    demo1.printMessage();
  }
}
