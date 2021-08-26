import 'package:flutter/material.dart';

//缩放路由动画
class JDScaleRouter<T> extends PageRouteBuilder<T> {
  JDScaleRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn,RouteSettings routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (BuildContext context, Animation<dynamic> animation,
                  Animation<dynamic> secondaryAnimation) =>
              child,
          transitionDuration: Duration(milliseconds: durationMs),
          transitionsBuilder: (BuildContext context, Animation<dynamic> a1,
                  Animation<dynamic> a2, Widget child) =>
              ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0)
                .animate(CurvedAnimation(parent: a1, curve: curve)),
            child: child,
          ),
        );

  final Widget child;
  final int durationMs;
  final Curve curve;
}

//渐变透明路由动画
class JDFadeRouter<T> extends PageRouteBuilder<T> {
  JDFadeRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn,RouteSettings routeSettings})
      : super(
            settings: routeSettings,
            pageBuilder: (BuildContext context, Animation<dynamic> animation,
                    Animation<dynamic> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: durationMs),
            transitionsBuilder: (BuildContext context, Animation<dynamic> a1,
                    Animation<dynamic> a2, Widget child) =>
                FadeTransition(
                  opacity: Tween<double>(begin: 0.1, end: 1.0)
                      .animate(CurvedAnimation(
                    parent: a1,
                    curve: curve,
                  )),
                  child: child,
                ));

  final Widget child;
  final int durationMs;
  final Curve curve;
}

//旋转路由动画
class JDRotateRouter<T> extends PageRouteBuilder<T> {
  JDRotateRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn})
      : super(
            pageBuilder: (BuildContext context, Animation<dynamic> animation,
                    Animation<dynamic> secondaryAnimation) =>
                child,
            transitionDuration: Duration(milliseconds: durationMs),
            transitionsBuilder: (BuildContext context, Animation<dynamic> a1,
                    Animation<dynamic> a2, Widget child) =>
                RotationTransition(
                  turns: Tween<double>(begin: 0.1, end: 1.0)
                      .animate(CurvedAnimation(
                    parent: a1,
                    curve: curve,
                  )),
                  child: child,
                ));

  final Widget child;
  final int durationMs;
  final Curve curve;
}

//右--->左
class JDRight2LeftRouter<T> extends PageRouteBuilder<T> {
  JDRight2LeftRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (BuildContext ctx, Animation<dynamic> a1,
                    Animation<dynamic> a2) =>
                child,
            transitionsBuilder: (
              BuildContext ctx,
              Animation<dynamic> a1,
              Animation<dynamic> a2,
              Widget child,
            ) =>
                SlideTransition(
                  child: child,
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                ));

  final Widget child;
  final int durationMs;
  final Curve curve;
}

//左--->右
class JDLeft2RightRouter<T> extends PageRouteBuilder<T> {
  JDLeft2RightRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn,RouteSettings routeSettings})
      : assert(true),
        super(
            settings: routeSettings,
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (BuildContext ctx, Animation<dynamic> a1,
                Animation<dynamic> a2) {
              return child;
            },
            transitionsBuilder: (
              BuildContext ctx,
              Animation<dynamic> a1,
              Animation<dynamic> a2,
              Widget child,
            ) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                  child: child);
            });

  final Widget child;
  final int durationMs;
  final Curve curve;
  List<int> mapper;
}

//上--->下
class JDTop2BottomRouter<T> extends PageRouteBuilder<T> {
  JDTop2BottomRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn,RouteSettings routeSettings})
      : super(
            settings: routeSettings,
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (BuildContext ctx, Animation<dynamic> a1, Animation<dynamic> a2) {
              return child;
            },
            transitionsBuilder: (
              BuildContext ctx,
                Animation<dynamic> a1,
                Animation<dynamic> a2,
              Widget child,
            ) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, -1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                  child: child);
            });

  final Widget child;
  final int durationMs;
  final Curve curve;
}

//下--->上
class JDBottom2TopRouter<T> extends PageRouteBuilder<T> {
  JDBottom2TopRouter(
      {this.child, this.durationMs = 500, this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (BuildContext ctx, Animation<dynamic> a1, Animation<dynamic> a2) => child,
            transitionsBuilder: (
              BuildContext ctx,
                Animation<dynamic> a1,
                Animation<dynamic> a2,
              Widget child,
            ) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                  child: child);
            });

  final Widget child;
  final int durationMs;
  final Curve curve;
}

//缩放+透明+旋转路由动画
class JDScaleFadeRotateRouter<T> extends PageRouteBuilder<T> {
  JDScaleFadeRotateRouter(
      {this.child, this.durationMs = 1000, this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: durationMs),
            pageBuilder: (BuildContext ctx,  Animation<dynamic> a1,  Animation<dynamic> a2) => child, //页面
            transitionsBuilder: (
              BuildContext ctx,
                Animation<dynamic> a1,
                Animation<dynamic> a2,
              Widget child,
            ) =>
                RotationTransition(
                  //旋转动画
                  turns: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: a1,
                    curve: curve,
                  )),
                  child: ScaleTransition(
                    //缩放动画
                    scale: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(parent: a1, curve: curve)),
                    child: FadeTransition(
                      opacity: //透明度动画
                           Tween<double>(begin: 0.5, end: 1.0).animate(
                              CurvedAnimation(parent: a1, curve: curve)),
                      child: child,
                    ),
                  ),
                ));

  final Widget child;
  final int durationMs;
  final Curve curve;
}


//无动画
class JDNoAnimRouter<T> extends PageRouteBuilder<T> {
  JDNoAnimRouter({Widget child,RouteSettings routeSettings})
      : super(
            settings: routeSettings,
            opaque: false,
            pageBuilder: (BuildContext context, Animation<dynamic> animation, Animation<dynamic> secondaryAnimation) => child,
            transitionDuration: const Duration(milliseconds: 0),
            transitionsBuilder:
                (BuildContext context, Animation<dynamic> animation, Animation<dynamic> secondaryAnimation,Widget child) => child,);
}
