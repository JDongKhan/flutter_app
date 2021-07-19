import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

import 'log_console.dart';

/// @author jd

class LogMenu {
  static bool isShow = false;
  static bool isShowLogConsole = false;
  static OverlayEntry _overlayEntry;

  static void show(BuildContext context) {
    if (isShow == true) {
      return;
    }
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return LogMenuWidget();
      },
    );
    Overlay.of(context).insert(_overlayEntry);
    isShow = true;
  }

  static void _gotLogConsole(BuildContext context) async {
    if (isShowLogConsole) {
      return;
    }
    isShowLogConsole = true;
    var logConsole = LogConsole(
      showCloseButton: true,
      dark: Theme.of(context).brightness == Brightness.dark,
    );
    await JDNavigationUtil.push(logConsole);
    isShowLogConsole = false;
  }

  static void remove() {
    _overlayEntry.remove();
    _overlayEntry = null;
    isShow = false;
  }
}

class LogMenuWidget extends StatefulWidget {
  @override
  _LogMenuWidgetState createState() => _LogMenuWidgetState();
}

double left = 0;
double top = 100;

class _LogMenuWidgetState extends State<LogMenuWidget> {
  int _animalDuration = 0;
  double _width = 60, _height = 60;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _animalDuration),
      top: top,
      left: left,
      width: _width,
      height: _height,
      child: GestureDetector(
        onTap: () {
          LogMenu._gotLogConsole(context);
        },
        onDoubleTap: () {
          LogMenu.remove();
        },
        onPanStart: (DragStartDetails details) {
          setState(() {
            _animalDuration = 1;
            _width = 80;
            _height = 80;
          });
        },
        onPanUpdate: (DragUpdateDetails detail) {
          left = left + detail.delta.dx;
          top = top + detail.delta.dy;
          left = max(0, left);
          top = max(0, top);
          left = min(jd_screenWidth() - 60, left);
          top = min(jd_screenHeight() - 60, top);
          setState(() {});
        },
        onPanEnd: (DragEndDetails details) {
          _handEnd();
        },
        onPanCancel: () {
          _handEnd();
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _handEnd() {
    _animalDuration = 300;
    _width = 60;
    _height = 60;
    if (left < jd_screenWidth() / 2) {
      setState(() {
        left = 0;
      });
    } else {
      setState(() {
        left = jd_screenWidth() - 60;
      });
    }
  }
}
