import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @author jd

final OrientationObserver defaultOrientationObserver = OrientationObserver();

abstract class OrientationAware {
  List<DeviceOrientation> orientations();
}

class OrientationObserver extends NavigatorObserver {
  static OrientationObserver observer;

  OrientationObserver({
    this.orientations = const [DeviceOrientation.portraitUp],
  });
  final List<DeviceOrientation> orientations;
  final Map<Route, OrientationAware> _orientationSubscribers = {};

  /// Only for internal usage.
  factory OrientationObserver.internalGet(BuildContext context) {
    observer ??= OrientationObserver();
    return observer;
  }

  void subscribe(OrientationAware aware, Route route) {
    _orientationSubscribers.putIfAbsent(route, () => aware);
    List<DeviceOrientation> orientations = aware.orientations();
    SystemChrome.setPreferredOrientations(orientations);
  }

  void unsubscribe(OrientationAware aware) {
    _orientationSubscribers.remove(aware);
  }

  void _reset(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return;
    _handleOrientations(route);
  }

  static void reset(BuildContext context) {
    OrientationObserver.internalGet(context)._reset(context);
  }

  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('App Observer - didPush');
  }

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('App Observer - didPop');
    _handleOrientations(previousRoute);
  }

  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('App Observer - didRemove');
    _handleOrientations(previousRoute);
  }

  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('App Observer - didReplace');
  }

  void _handleOrientations(Route<dynamic> route) {
    OrientationAware orientationAware = _orientationSubscribers[route];
    List<DeviceOrientation> orientations = null;
    if (orientationAware == null) {
      orientations = this.orientations;
    } else {
      orientations = orientationAware.orientations();
    }
    SystemChrome.setPreferredOrientations(orientations);
  }

  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('App Observer - didStartUserGesture');
  }

  void didStopUserGesture() {
    print('App Observer - didStopUserGesture');
  }
}
