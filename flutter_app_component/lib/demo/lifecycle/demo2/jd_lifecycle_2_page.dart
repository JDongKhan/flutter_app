import 'package:flutter/material.dart';

/// @author jd

class JDLifecycle2Page extends StatefulWidget {
  @override
  _JDLifecycle2PageState createState() => _JDLifecycle2PageState();
}

class _JDLifecycle2PageState extends State<JDLifecycle2Page> {
  @override
  Widget build(BuildContext context) {
    print('Page B deactivate');
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
      ),
      body: Container(
        child: Text('请进入控制台查看日志'),
      ),
    );
  }

  @override
  void initState() {
    print('Page B initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('Page B didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    print('Page B reassemble');
  }

  @override
  void deactivate() {
    print('Page B deactivate');
  }

  @override
  void didUpdateWidget(JDLifecycle2Page oldWidget) {
    print('Page B didUpdateWidget');
  }

  @override
  void dispose() {
    print('Page B dispose');
    super.dispose();
  }
}
