import 'package:flutter/material.dart';

/// @author jd
enum JDVisibilityType {
  visible,
  invisible,
  offscreen,
  gone,
}

class JDVisibility extends StatelessWidget {
  JDVisibility({
    @required this.child,
    @required this.visibility,
  }) : removeChild = Container();

  final JDVisibilityType visibility;
  final Widget child;
  final Widget removeChild;

  @override
  Widget build(BuildContext context) {
    if (visibility == JDVisibilityType.visible) {
      return child;
    } else if (visibility == JDVisibilityType.invisible) {
      return IgnorePointer(
          ignoring: true, child: Opacity(opacity: 0.0, child: child));
    } else if (visibility == JDVisibilityType.offscreen) {
      return Offstage(offstage: true, child: child);
    } else {
      return removeChild;
    }
  }
}
