import 'dart:math';

import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */


class JDSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  JDSliverPersistentHeaderDelegate(@required this.minHeight,@required this.maxHeight,@required this.child);
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => max(maxHeight,minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(JDSliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent || minHeight != oldDelegate.minExtent || child != oldDelegate.child;
  }

}