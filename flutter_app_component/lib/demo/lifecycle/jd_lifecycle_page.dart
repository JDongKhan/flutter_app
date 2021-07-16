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
    print('Page A build');
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeCycle'),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text('mixin'),
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
    print('Page A initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('Page A didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    print('Page A reassemble');
  }

  @override
  void deactivate() {
    print('Page A deactivate');
  }

  @override
  void didUpdateWidget(JDLifeCyclePage oldWidget) {
    print('Page A didUpdateWidget');
  }

  @override
  void dispose() {
    print('Page A dispose');
    super.dispose();
  }
}
