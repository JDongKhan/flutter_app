import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/logger/log_menu.dart';

import 'shake_detector.dart';

class LogConsoleOnShake extends StatefulWidget {
  final Widget child;
  final bool dark;
  final bool debugOnly;

  LogConsoleOnShake({
    @required this.child,
    this.dark,
    this.debugOnly = true,
  });

  @override
  _LogConsoleOnShakeState createState() => _LogConsoleOnShakeState();
}

class _LogConsoleOnShakeState extends State<LogConsoleOnShake> {
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

  _init() {
    _detector = ShakeDetector(onPhoneShake: _openLogConsole);
    _detector.startListening();
  }

  _openLogConsole() async {
    LogMenu.show(context);
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
