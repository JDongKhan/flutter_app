import 'package:flutter/material.dart';

// TapboxA 管理自身状态.

//------------------------- TapboxA ----------------------------------

class JDTapboxA extends StatefulWidget {
  JDTapboxA({Key key}) : super(key: key);

  @override
  State createState() => new _JDTapboxAState();
}

class _JDTapboxAState extends State<JDTapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}