import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/debug/menu_page.dart';
import 'package:jd_core/jd_core.dart';

FloatMenuController floatMenuController = FloatMenuController();

class FloatMenuController {
  FloatMenuController();

  bool _isShow = false;
  bool _isShowLogConsole = false;
  OverlayEntry _overlayEntry;

  void show(BuildContext context) {
    if (_isShow == true) {
      return;
    }
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return FloatMenuWidget();
      },
    );
    Overlay.of(context).insert(_overlayEntry);
    _isShow = true;
  }

  // ignore: avoid_void_async
  void gotoLogConsole(BuildContext context) async {
    if (_isShowLogConsole) {
      return;
    }
    _isShowLogConsole = true;
    final MenuPage menu = MenuPage();
    await JDNavigationUtil.push(menu);
    _isShowLogConsole = false;
  }

  void remove() {
    _overlayEntry.remove();
    _overlayEntry = null;
    _isShow = false;
  }
}

class FloatMenuWidget extends StatefulWidget {
  @override
  _FloatMenuWidgetState createState() => _FloatMenuWidgetState();
}

double left = 0;
double top = 100;

class _FloatMenuWidgetState extends State<FloatMenuWidget> {
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
          floatMenuController.gotoLogConsole(context);
        },
        onDoubleTap: () {
          floatMenuController.remove();
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
