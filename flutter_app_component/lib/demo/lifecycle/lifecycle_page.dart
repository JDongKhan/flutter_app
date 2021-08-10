import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/lifecycle/demo2/life_cycle_2_page.dart';

import 'demo1/life_cycle_demo_1.dart';
import 'life_cycle_stateless_page.dart';

/// @author jd

class LifeCyclePage extends StatefulWidget {
  @override
  _LifeCyclePageState createState() => _LifeCyclePageState();
}

class _LifeCyclePageState extends State<LifeCyclePage> {
  LifeCyclController _controller = LifeCyclController();
  @override
  Widget build(BuildContext context) {
    debugPrint('Page A build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeCycle'),
      ),
      body: Column(
        children: [
          TextButton(
            child: const Text('mixin and extension'),
            onPressed: () {
              _test1();
            },
          ),
          TextButton(
            child: const Text('NextPage'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Lifecycle2Page(),
                ),
              );
            },
          ),
          TextButton(
            child: const Text('setStatus'),
            onPressed: () {
              setState(() {});
            },
          ),
          LifeCycleStatelessPage(
            controller: _controller,
          ),
        ],
      ),
    );
  }

  void _test1() {
    Demo1 demo1 = Demo1();
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
  void didUpdateWidget(LifeCyclePage oldWidget) {
    debugPrint('Page A didUpdateWidget');
  }

  @override
  void dispose() {
    debugPrint('Page A dispose');
    super.dispose();
  }
}
