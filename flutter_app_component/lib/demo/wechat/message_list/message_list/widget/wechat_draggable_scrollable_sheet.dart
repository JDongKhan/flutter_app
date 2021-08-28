import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// @author jd
class WechatDraggableScrollableSheet extends StatefulWidget {
  /// Creates a widget that can be dragged and scrolled in a single gesture.
  ///
  /// The [builder], [initialChildSize], [minChildSize], [maxChildSize] and
  /// [expand] parameters must not be null.
  const WechatDraggableScrollableSheet({
    Key key,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 1.0,
    this.expand = true,
    @required this.animationController,
    @required this.builder,
  })  : assert(initialChildSize != null),
        assert(minChildSize != null),
        assert(maxChildSize != null),
        assert(minChildSize >= 0.0),
        assert(maxChildSize <= 1.0),
        assert(minChildSize <= initialChildSize),
        assert(initialChildSize <= maxChildSize),
        assert(expand != null),
        assert(builder != null),
        super(key: key);

  /// The initial fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `0.5`.
  final double initialChildSize;

  /// The minimum fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `0.25`.
  final double minChildSize;

  /// The maximum fractional value of the parent container's height to use when
  /// displaying the widget.
  ///
  /// The default value is `1.0`.
  final double maxChildSize;

  /// Whether the widget should expand to fill the available space in its parent
  /// or not.
  ///
  /// In most cases, this should be true. However, in the case of a parent
  /// widget that will position this one based on its desired size (such as a
  /// [Center]), this should be set to false.
  ///
  /// The default value is true.
  final bool expand;

  /// The builder that creates a child to display in this widget, which will
  /// use the provided [ScrollController] to enable dragging and scrolling
  /// of the contents.
  final ScrollableWidgetBuilder builder;

  final AnimationController animationController;

  @override
  _WechatDraggableScrollableSheetState createState() =>
      _WechatDraggableScrollableSheetState();
}

class _WechatDraggableScrollableSheetState
    extends State<WechatDraggableScrollableSheet> {
  _DraggableScrollableSheetScrollController _scrollController;
  _DraggableSheetExtent _extent;

  @override
  void initState() {
    super.initState();
    _extent = _DraggableSheetExtent(
      minExtent: widget.minChildSize,
      maxExtent: widget.maxChildSize,
      initialExtent: widget.initialChildSize,
      listener: _setExtent,
    );
    _scrollController =
        _DraggableScrollableSheetScrollController(extent: _extent);
    widget.animationController.value = _extent.currentExtent;
    widget.animationController.addListener(_listener);
  }

  //通过AnimationController来控制
  void _listener() {
    _extent.currentExtent = widget.animationController.value;
    DraggableScrollableNotification(
      minExtent: _extent.minExtent,
      maxExtent: _extent.maxExtent,
      extent: _extent.currentExtent,
      initialExtent: _extent.initialExtent,
      context: context,
    ).dispatch(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_InheritedResetNotifier.shouldReset(context)) {
      // jumpTo can result in trying to replace semantics during build.
      // Just animate really fast.
      // Avoid doing it at all if the offset is already 0.0.
      if (_scrollController.offset != 0.0) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 1),
          curve: Curves.linear,
        );
      }
      _extent._currentExtent.value = _extent.initialExtent;
    }
  }

  void _setExtent() {
    setState(() {
      // _extent has been updated when this is called.
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _extent.availablePixels =
            widget.maxChildSize * constraints.biggest.height;
        final Widget sheet = FractionallySizedBox(
          heightFactor: _extent.currentExtent,
          child: widget.builder(context, _scrollController),
          alignment: Alignment.bottomCenter,
        );

        final Widget notificationWidget =
            NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              widget.animationController.value = _extent.currentExtent;
              double extent = 0.0;
              if (_extent.currentExtent > 0.5) {
                extent = 1.0;
                debugPrint('手势结束，恢复界面');
              } else {
                debugPrint('手势结束，消失界面');
              }
              widget.animationController.animateTo(extent);
            }
            return true;
          },
          child: sheet,
        );

        return widget.expand
            ? SizedBox.expand(child: notificationWidget)
            : notificationWidget;
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _DraggableSheetExtent {
  _DraggableSheetExtent({
    @required this.minExtent,
    @required this.maxExtent,
    @required this.initialExtent,
    @required VoidCallback listener,
  })  : assert(minExtent != null),
        assert(maxExtent != null),
        assert(initialExtent != null),
        assert(minExtent >= 0),
        assert(maxExtent <= 1),
        assert(minExtent <= initialExtent),
        assert(initialExtent <= maxExtent),
        _currentExtent = ValueNotifier<double>(initialExtent)
          ..addListener(listener),
        availablePixels = double.infinity;

  final double minExtent;
  final double maxExtent;
  final double initialExtent;
  final ValueNotifier<double> _currentExtent;
  double availablePixels;

  bool get isAtMin => minExtent >= _currentExtent.value;
  bool get isAtMax => maxExtent <= _currentExtent.value;

  set currentExtent(double value) {
    assert(value != null);
    _currentExtent.value = value.clamp(minExtent, maxExtent);
  }

  double get currentExtent => _currentExtent.value;

  double get additionalMinExtent => isAtMin ? 0.0 : 1.0;
  double get additionalMaxExtent => isAtMax ? 0.0 : 1.0;

  /// The scroll position gets inputs in terms of pixels, but the extent is
  /// expected to be expressed as a number between 0..1.
  void addPixelDelta(double delta, BuildContext context) {
    if (availablePixels == 0) {
      return;
    }
    currentExtent += delta / availablePixels * maxExtent;
    DraggableScrollableNotification(
      minExtent: minExtent,
      maxExtent: maxExtent,
      extent: currentExtent,
      initialExtent: initialExtent,
      context: context,
    ).dispatch(context);
  }
}

class _DraggableScrollableSheetScrollController extends ScrollController {
  _DraggableScrollableSheetScrollController({
    double initialScrollOffset = 0.0,
    String debugLabel,
    @required this.extent,
  })  : assert(extent != null),
        super(
          debugLabel: debugLabel,
          initialScrollOffset: initialScrollOffset,
        );

  final _DraggableSheetExtent extent;

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

  VoidCallback _dragCancelCallback;
  final _DraggableSheetExtent extent;
  bool get listShouldScroll => pixels > 0.0;

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    // We need to provide some extra extent if we haven't yet reached the max or
    // min extents. Otherwise, a list with fewer children than the extent of
    // the available space will get stuck.
    return super.applyContentDimensions(
      minScrollExtent - extent.additionalMinExtent,
      maxScrollExtent + extent.additionalMaxExtent,
    );
  }

  @override
  void applyUserOffset(double delta) {
    if (!listShouldScroll &&
        (!(extent.isAtMin || extent.isAtMax) ||
            (extent.isAtMin && delta < 0) ||
            (extent.isAtMax && delta > 0))) {
      extent.addPixelDelta(-delta, context.notificationContext);
    } else {
      super.applyUserOffset(delta);
    }
  }

  @override
  void goBallistic(double velocity) {
    if (velocity == 0.0 ||
        (velocity < 0.0 && listShouldScroll) ||
        (velocity > 0.0 && extent.isAtMax)) {
      super.goBallistic(velocity);
      return;
    }
    // Scrollable expects that we will dispose of its current _dragCancelCallback
    _dragCancelCallback?.call();
    _dragCancelCallback = null;

    // The iOS bouncing simulation just isn't right here - once we delegate
    // the ballistic back to the ScrollView, it will use the right simulation.
    final Simulation simulation = ClampingScrollSimulation(
      position: extent.currentExtent,
      velocity: velocity,
      tolerance: physics.tolerance,
    );

    final AnimationController ballisticController =
        AnimationController.unbounded(
      debugLabel: objectRuntimeType(this, '_DraggableScrollableSheetPosition'),
      vsync: context.vsync,
    );
    double lastDelta = 0;
    void _tick() {
      final double delta = ballisticController.value - lastDelta;
      lastDelta = ballisticController.value;
      extent.addPixelDelta(delta, context.notificationContext);
      if ((velocity > 0 && extent.isAtMax) ||
          (velocity < 0 && extent.isAtMin)) {
        // Make sure we pass along enough velocity to keep scrolling - otherwise
        // we just "bounce" off the top making it look like the list doesn't
        // have more to scroll.
        velocity = ballisticController.velocity +
            (physics.tolerance.velocity * ballisticController.velocity.sign);
        super.goBallistic(velocity);
        ballisticController.stop();
      } else if (ballisticController.isCompleted) {
        super.goBallistic(0);
      }
    }

    ballisticController
      ..addListener(_tick)
      ..animateWith(simulation).whenCompleteOrCancel(
        ballisticController.dispose,
      );
  }

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    // Save this so we can call it later if we have to [goBallistic] on our own.
    _dragCancelCallback = dragCancelCallback;
    return super.drag(details, dragCancelCallback);
  }
}

/// A [ChangeNotifier] to use with [InheritedResetNotifier] to notify
/// descendants that they should reset to initial state.
class _ResetNotifier extends ChangeNotifier {
  /// Whether someone called [sendReset] or not.
  ///
  /// This flag should be reset after checking it.
  bool _wasCalled = false;

  /// Fires a reset notification to descendants.
  ///
  /// Returns false if there are no listeners.
  bool sendReset() {
    if (!hasListeners) {
      return false;
    }
    _wasCalled = true;
    notifyListeners();
    return true;
  }
}

class _InheritedResetNotifier extends InheritedNotifier<_ResetNotifier> {
  /// Creates an [InheritedNotifier] that the [DraggableScrollableSheet] will
  /// listen to for an indication that it should change its extent.
  ///
  /// The [child] and [notifier] properties must not be null.
  const _InheritedResetNotifier({
    Key key,
    @required Widget child,
    @required _ResetNotifier notifier,
  }) : super(key: key, child: child, notifier: notifier);

  bool _sendReset() => notifier.sendReset();

  /// Specifies whether the [DraggableScrollableSheet] should reset to its
  /// initial position.
  ///
  /// Returns true if the notifier requested a reset, false otherwise.
  static bool shouldReset(BuildContext context) {
    final InheritedWidget widget =
        context.dependOnInheritedWidgetOfExactType<_InheritedResetNotifier>();
    if (widget == null) {
      return false;
    }
    assert(widget is _InheritedResetNotifier);
    final _InheritedResetNotifier inheritedNotifier =
        widget as _InheritedResetNotifier;
    final bool wasCalled = inheritedNotifier.notifier._wasCalled;
    inheritedNotifier.notifier._wasCalled = false;
    return wasCalled;
  }
}
