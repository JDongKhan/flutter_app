import 'package:flutter/material.dart';

// TapboxA 管理自身状态.

//------------------------- TapboxA ----------------------------------

class TapboxAPage extends StatefulWidget {
  TapboxAPage({Key key}) : super(key: key);

  @override
  State createState() => _TapboxAPageState();
}

class _TapboxAPageState extends State<TapboxAPage> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          child: Center(
            child: Text(
              _active ? 'Active' : 'Inactive',
              style: TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
