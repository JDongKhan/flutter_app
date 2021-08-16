import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/debug/float_menu_controller.dart';

import 'shake_detector.dart';

class MenuConsoleOnShake extends StatefulWidget {
  const MenuConsoleOnShake({
    @required this.child,
    this.dark,
    this.debugOnly = true,
  });

  final Widget child;
  final bool dark;
  final bool debugOnly;

  @override
  _MenuConsoleOnShakeState createState() => _MenuConsoleOnShakeState();
}

class _MenuConsoleOnShakeState extends State<MenuConsoleOnShake> {
  ShakeDetector _detector;

  @override
  void initState() {
    super.initState();

    if (widget.debugOnly) {
      assert(() {
        _init();
        return true;
      }());
    } else {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _init() {
    _detector = ShakeDetector(onPhoneShake: _openLogConsole);
    _detector.startListening();
  }

  void _openLogConsole() async {
    floatMenuController.show(context);
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
