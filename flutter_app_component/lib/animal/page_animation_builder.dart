import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

class PageAnimationBuilder {
  //no animal
  static Route<dynamic> noAnim<T>(Widget page, RouteSettings routeSettings) {
    return JDNoAnimRouter<T>(child: page, routeSettings: routeSettings);
  }

  ///fade
  static Route<dynamic> fadeAnim<T>(Widget page, RouteSettings routeSettings) {
    return JDFadeRouter<T>(child: page, routeSettings: routeSettings);
  }

  ///slide
  static Route<dynamic> slideAnim<T>(Widget page, RouteSettings routeSettings) {
    return JDLeft2RightRouter<T>(
      child: page,
      routeSettings: routeSettings,
    );
  }

  static Route<dynamic> slideTopAnim<T>(
      Widget page, RouteSettings routeSettings) {
    return JDTop2BottomRouter<T>(child: page, routeSettings: routeSettings);
  }

  ///scale
  static Route<dynamic> scaleAnim<T>(Widget page, RouteSettings routeSettings) {
    return JDScaleRouter<T>(child: page, routeSettings: routeSettings);
  }
}
