import 'package:flutter/material.dart';
// ParentWidget 为 TapboxB 管理状态.

//------------------------ ParentWidget --------------------------------

class JDParentWidgetB extends StatefulWidget {
  @override
  State createState() => new _JDParentWidgetBState();
}

class _JDParentWidgetBState extends State<JDParentWidgetB> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: JDTapboxB(
          active: _active,
          onChanged: _handleTapboxChanged,
        ),
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class JDTapboxB extends StatelessWidget {
  JDTapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
