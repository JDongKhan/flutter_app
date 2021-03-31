import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/widget/webview/web_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import 'jd_object_utils.dart';

/// @author jd

class JDNavigationUtil {
  factory JDNavigationUtil.getInstance() => _getInstance();

  JDNavigationUtil._internal();

  static JDNavigationUtil _instance;

  static JDNavigationUtil _getInstance() {
    return _instance = _instance ?? JDNavigationUtil._internal();
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> _pushNamed(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> _push(Widget page) {
    return navigatorKey.currentState
        .push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) {
      return page;
    }));
  }

  Future<dynamic> _pushReplacementNamed(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> _pushReplacement(Widget page) {
    return navigatorKey.currentState.pushReplacement(
        CupertinoPageRoute<dynamic>(builder: (BuildContext context) {
      return page;
    }));
  }

  void _goBack() {
    navigatorKey.currentState.pop();
  }

  void _popToRoot() {
    navigatorKey.currentState.popUntil(
      (Route<dynamic> route) => route.isFirst,
    );
    //route返回的是false则从会路由队列清除。
    // navigatorKey.currentState.pushAndRemoveUntil(
    //   CupertinoPageRoute<dynamic>(
    //     builder: (_) => JDScaffoldPage(),
    //   ),
    //   (route) => false,
    // );
  }

  void _pushWeb(
      {String title, String titleId, String url, bool isHome: false}) {
    if (ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      navigatorKey.currentState.push(CupertinoPageRoute<void>(
          builder: (BuildContext ctx) => WebScaffold(
                title: title,
                titleId: titleId,
                url: url,
              )));
    }
  }

  static Future<dynamic> pushNamed(
    String routeName, {
    Object arguments,
  }) {
    return JDNavigationUtil.getInstance()
        ._pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(Widget page) {
    return JDNavigationUtil.getInstance()._push(page);
  }

  static Future<dynamic> pushReplacementNamed(
    String routeName, {
    Object arguments,
  }) {
    return JDNavigationUtil.getInstance()
        ._pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> pushReplacement(Widget page) {
    return JDNavigationUtil.getInstance()._pushReplacement(page);
  }

  static void goBack() {
    JDNavigationUtil.getInstance()._goBack();
  }

  static void popToRoot() {
    JDNavigationUtil.getInstance()._popToRoot();
  }

  static void pushWebView(
      {String title, String titleId, String url, bool isHome: false}) {
    JDNavigationUtil.getInstance()
        ._pushWeb(title: title, titleId: titleId, url: url, isHome: isHome);
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
