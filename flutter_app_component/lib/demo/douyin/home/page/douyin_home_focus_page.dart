import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd
/// 关注

class DouyinHomeoFocusPage extends StatefulWidget {
  @override
  _DouyinHomeoFocusPageState createState() => _DouyinHomeoFocusPageState();
}

class _DouyinHomeoFocusPageState extends State<DouyinHomeoFocusPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.only(
        top: kToolbarHeight + MediaQuery.of(context).padding.top,
      ),
      child: const Center(
        child: Text(
          '需要登录',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
