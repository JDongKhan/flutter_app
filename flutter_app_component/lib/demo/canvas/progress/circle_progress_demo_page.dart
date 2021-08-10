import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/canvas/progress/circle_progress.dart';

/// @author jd

class CircleProgressDemoPage extends StatefulWidget {
  @override
  _CircleProgressDemoPageState createState() => _CircleProgressDemoPageState();
}

class _CircleProgressDemoPageState extends State<CircleProgressDemoPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Circle Progress Demo'),
      ),
      body: Center(
        child: CircleProgressWidget(
          progress: Progress(
            value: _animationController.value,
          ),
        ),
      ),
    );
  }
}
