import 'package:flutter/material.dart';

/// @author jd

class JDLifecycle2Page extends StatefulWidget {
  @override
  _JDLifecycle2PageState createState() => _JDLifecycle2PageState();
}

class _JDLifecycle2PageState extends State<JDLifecycle2Page> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Page B deactivate');
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
    debugPrint('Page B initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('Page B didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    debugPrint('Page B reassemble');
  }

  @override
  void deactivate() {
    debugPrint('Page B deactivate');
  }

  @override
  void didUpdateWidget(JDLifecycle2Page oldWidget) {
    debugPrint('Page B didUpdateWidget');
  }

  @override
  void dispose() {
    debugPrint('Page B dispose');
    super.dispose();
  }
}
