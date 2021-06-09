import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:widget_chain/widget_chain.dart';

class JDCircleProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPainter'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: RectLayout(
              child: Text('helloworld').intoContainer(color: Colors.blue),
            ),
          ).intoContainer(color: Colors.red),
          SizedBox(
            height: 500,
            child: GridLayout(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JDAssetBundle.getImgPath('ali_connors'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JDAssetBundle.getImgPath('ali_connors'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JDAssetBundle.getImgPath('ali_connors'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JDAssetBundle.getImgPath('ali_connors'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JDAssetBundle.getImgPath('ali_connors'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      JDAssetBundle.getImgPath('ali_connors'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RectLayout extends StatelessWidget {
  RectLayout({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: RectLayoutDelegate(),
      child: child,
    );
  }
}

class RectLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double dx = (size.width - childSize.width) / 2;
    double dy = (size.height - childSize.height) / 2;
    return Offset(dx, dy);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxEdge = min(constraints.maxWidth, constraints.maxHeight);
    return BoxConstraints(maxWidth: maxEdge, maxHeight: maxEdge);
  }
}

class GridLayout extends StatelessWidget {
  GridLayout({
    @required this.children,
    this.horizontalSpace = 0,
    this.verticalSpace = 0,
  });
  final List<Widget> children;
  final double horizontalSpace;
  final double verticalSpace;

  @override
  Widget build(BuildContext context) {
    List<Widget> layoutChildren = [];
    for (int index = 0; index < children.length; index++) {
      layoutChildren.add(LayoutId(
        id: index,
        child: children[index],
      ));
    }

    return CustomMultiChildLayout(
      delegate: GridLayoutDelegate(
          horizontalSpace: horizontalSpace, verticalSpace: verticalSpace),
      children: layoutChildren,
    );
  }
}

class GridLayoutDelegate extends MultiChildLayoutDelegate {
  GridLayoutDelegate({this.horizontalSpace, this.verticalSpace});
  final double horizontalSpace;
  final double verticalSpace;

  final List<Size> _itemSizes = [];

  @override
  void performLayout(Size size) {
    int index = 0;
    final double width = (size.width - horizontalSpace) / 2;
    final BoxConstraints itemConstraints = BoxConstraints(
        minWidth: width, maxWidth: width, maxHeight: double.infinity);

    while (hasChild(index)) {
      _itemSizes.add(layoutChild(index, itemConstraints));
      index++;
    }
    index = 0;
    double dx = 0;
    double dy = 0;

    while (hasChild(index)) {
      positionChild(index, Offset(dx, dy));
      dx = index % 2 == 0 ? width + horizontalSpace : 0;
      if (index % 2 == 1) {
        double maxHeight =
            max(_itemSizes[index].height, _itemSizes[index - 1].height);
        dy += maxHeight + verticalSpace;
      }
      index++;
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
