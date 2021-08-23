import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// @author jd
///

class DraggableSheetExtent {
  DraggableSheetExtent({
    this.onEndListener,
    @required this.listener,
  });
  double _currentExtent = 0;
  final VoidCallback onEndListener;
  final VoidCallback listener;

  set currentExtent(double value) {
    assert(value != null);
    _currentExtent = value;
    //防止导航跑上面去了
    _currentExtent = max(0, value);
    if (listener != null) {
      listener();
    }
  }

  double get currentExtent => _currentExtent;

  /// The scroll position gets inputs in terms of pixels, but the extent is
  /// expected to be expressed as a number between 0..1.
  void addPixelDelta(double delta, BuildContext context) {
    currentExtent += delta;
  }
}

class DraggableScrollableSheetScrollController extends ScrollController {
  DraggableScrollableSheetScrollController({
    double initialScrollOffset = 0.0,
    String debugLabel,
    @required this.extent,
  })  : assert(extent != null),
        super(
          debugLabel: debugLabel,
          initialScrollOffset: initialScrollOffset,
        );

  final DraggableSheetExtent extent;

  @override
  _DraggableScrollableSheetScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition,
  ) {
    return _DraggableScrollableSheetScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      extent: extent,
    );
  }

  @override
  void debugFillDescription(List<String> description) {
    super.debugFillDescription(description);
    description.add('extent: $extent');
  }
}

/// A scroll position that manages scroll activities for
/// [_DraggableScrollableSheetScrollController].
///
/// This class is a concrete subclass of [ScrollPosition] logic that handles a
/// single [ScrollContext], such as a [Scrollable]. An instance of this class
/// manages [ScrollActivity] instances, which changes the
/// [_DraggableSheetExtent.currentExtent] or visible content offset in the
/// [Scrollable]'s [Viewport]
///
/// See also:
///
///  * [_DraggableScrollableSheetScrollController], which uses this as its [ScrollPosition].
class _DraggableScrollableSheetScrollPosition
    extends ScrollPositionWithSingleContext {
  _DraggableScrollableSheetScrollPosition({
    @required ScrollPhysics physics,
    @required ScrollContext context,
    double initialPixels = 0.0,
    bool keepScrollOffset = true,
    ScrollPosition oldPosition,
    String debugLabel,
    @required this.extent,
  })  : assert(extent != null),
        super(
          physics: physics,
          context: context,
          initialPixels: initialPixels,
          keepScrollOffset: keepScrollOffset,
          oldPosition: oldPosition,
          debugLabel: debugLabel,
        );

  final DraggableSheetExtent extent;
  bool get listShouldScroll => pixels > 0.0;

  @override
  void applyUserOffset(double delta) {
    if (delta > 0 && !listShouldScroll) {
      //如果下拉，并且内容没有滚动
      extent.addPixelDelta(delta, context.notificationContext);
    } else if (delta < 0 && extent.currentExtent > 0) {
      //如果上拉，并且正处于整体下移状态
      extent.addPixelDelta(delta, context.notificationContext);
    } else {
      super.applyUserOffset(delta);
    }
  }

  @override
  void goBallistic(double velocity) {
    if (velocity == 0.0 && extent.currentExtent > 0) {
      //只是为了告诉外面，手势滑动结束了，如果有其他更好的地方最好，这里存在体验不好的问题
      extent.onEndListener();
      extent._currentExtent = 0;
    }
    super.goBallistic(velocity);
  }
}
