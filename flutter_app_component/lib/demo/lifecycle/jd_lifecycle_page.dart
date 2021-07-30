import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/lifecycle/demo2/jd_lifecycle_2_page.dart';

import 'demo1/jd_demo_1.dart';

/// @author jd

class JDLifeCyclePage extends StatefulWidget {
  @override
  _JDLifeCyclePageState createState() => _JDLifeCyclePageState();
}

class _JDLifeCyclePageState extends State<JDLifeCyclePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Page A build');
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeCycle'),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text('mixin and extension'),
            onPressed: () {
              _test1();
            },
          ),
          TextButton(
            child: Text('NextPage'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => JDLifecycle2Page(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _test1() {
    JDDemo1 demo1 = JDDemo1();
    demo1.printMessage();
  }

  @override
  void initState() {
    debugPrint('Page A initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('Page A didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    debugPrint('Page A reassemble');
  }

  @override
  void deactivate() {
    debugPrint('Page A deactivate');
  }

  @override
  void didUpdateWidget(JDLifeCyclePage oldWidget) {
    debugPrint('Page A didUpdateWidget');
  }

  @override
  void dispose() {
    debugPrint('Page A dispose');
    super.dispose();
  }
}
