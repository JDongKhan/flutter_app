import 'dart:async';

import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

/// @author jd
///
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _initialized = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            '欢迎光临！',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(milliseconds: 2000), () {
        Routemaster.of(context).replace('/home');
        // RouterManager.router
        //     .navigateTo(context, RouterManager.homePath, clearStack: true);
        //Navigator.of(context).pushReplacementNamed(RouterTable.homePath);
      });
    }
  }
}
