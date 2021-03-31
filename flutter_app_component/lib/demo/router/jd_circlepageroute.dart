import 'dart:math';

import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDCirclePageRoutePage<T> extends PageRoute<T> {

  JDCirclePageRoutePage({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context,child)  {
        return ClipPath(
          clipper: CiclePath(animation.value),
          child: child,
        );
      },
      child: builder(context),
    );
  }



}


class CiclePath extends CustomClipper<Path> {

  final double value;

  CiclePath(this.value);

  @override
  Path getClip(Size size) {
    var path = Path();
    double radius = value * sqrt(size.height * size.height + size.width * size.width);
    path.addOval(Rect.fromLTRB(size.width - radius, -radius, size.width + radius, radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
