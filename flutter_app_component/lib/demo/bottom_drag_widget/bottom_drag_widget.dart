import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///上拉抽屉
class BottomDragWidget extends StatelessWidget {
  const BottomDragWidget({
    Key key,
    @required this.body,
    @required this.dragContainer,
  })  : assert(body != null),
        assert(dragContainer != null),
        super(key: key);

  final Widget body;
  final DragContainer dragContainer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        Align(
          alignment: Alignment.bottomCenter,
          child: dragContainer,
        )
      ],
    );
  }
}

class DragContainerController extends ChangeNotifier {
  double _childSize;
  set childSize(double value) {
    _childSize = value;
    notifyListeners();
  }
}

class DragContainer extends StatelessWidget {
  const DragContainer({
    Key key,
    @required this.child,
    this.initialChildSize = 0.2,
    this.minChildSize = 0.2,
    this.maxChildSize = 1,
    this.maxHeight,
    this.onChanged,
    this.onBottom,
    this.controller,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final ValueChanged<double> onChanged;
  final Function onBottom;
  final double maxHeight;
  final DragContainerController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _DragContainer(
        child: child,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        initialChildSize: initialChildSize,
        maxHeight: maxHeight ?? constraints.maxHeight,
        onChanged: onChanged,
        onBottom: onBottom,
        controller: controller,
      );
    });
  }
}

class _DragContainer extends StatefulWidget {
  const _DragContainer({
    Key key,
    @required this.child,
    @required this.initialChildSize,
    @required this.minChildSize,
    @required this.maxChildSize,
    @required this.maxHeight,
    this.onChanged,
    this.onBottom,
    this.controller,
  })  : assert(child != null),
        assert(initialChildSize != null),
        assert(minChildSize != null),
        assert(maxChildSize != null),
        assert(maxHeight != null),
        super(key: key);

  final Widget child;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final double maxHeight;
  final ValueChanged<double> onChanged;
  final Function onBottom;
  final DragContainerController controller;

  @override
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<_DragContainer>
    with TickerProviderStateMixin {
  AnimationController _animalController;

  bool _onResetControllerValue = false;

  Animation<double> _animation;
  //是否显示顶层的手势widget
  bool _offstage = false;

  bool _isFling = false;

  //对上的偏移量
  double _offset;

  set offset(double value) {
    _offset = value;
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  double get offset => _offset;

  ///中间边界位置 滑动位置超过这个位置，会滚到顶部；小于，会滚动底部。
  double get centerOffset => widget.maxHeight * (1 - widget.minChildSize) * 0.5;

  //最大偏移量
  double get maxOffset => widget.maxHeight * (1 - widget.minChildSize);
  double get minOffset => widget.maxHeight * (1 - widget.maxChildSize);
  //默认显示的偏移
  double get defaultOffset => widget.maxHeight * (1 - widget.initialChildSize);

  @override
  void initState() {
    _animalController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    if (widget.controller != null) {
      widget.controller.addListener(() {
        _animalController.value = 0.0;
        double end = widget.maxHeight * (1 - widget.controller._childSize);
        _animalTo(end);
        // setState(() {
        //
        // });
      });
    }
    super.initState();
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>
      getRecognizer() {
    return GestureRecognizerFactoryWithHandlers<
        MyVerticalDragGestureRecognizer>(
      () => MyVerticalDragGestureRecognizer(flingListener: (bool isFling) {
        _isFling = isFling;
      }), //constructor
      (MyVerticalDragGestureRecognizer instance) {
        //initializer
        instance
          ..onStart = _handleDragStart
          ..onUpdate = _handleDragUpdate
          ..onEnd = _handleDragEnd;
      },
    );
  }

  @override
  void dispose() {
    _animalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (offset == null || _onResetControllerValue) {
      ///说明是第一次加载,由于BottomDragWidget中 alignment: Alignment.bottomCenter,故直接设置
      offset = defaultOffset;
    }

    ///偏移值在这个范围内
    offset = offset.clamp(minOffset, maxOffset);
    _offstage = offset < centerOffset;
    return Transform.translate(
      offset: Offset(0.0, offset),
      child: RawGestureDetector(
        gestures: {MyVerticalDragGestureRecognizer: getRecognizer()},
        child: Stack(
          children: <Widget>[
            OverscrollNotificationWidget(
              notification:
                  (double value, ScrollNotificationListener notification) {
                if (notification == ScrollNotificationListener.start) {
                  _handleDragEnd(null);
                } else if (notification == ScrollNotificationListener.end) {
                  _handleDragEnd(null);
                } else if (notification == ScrollNotificationListener.update) {
                  // widget.controller.childSize = 1;
                } else if (notification == ScrollNotificationListener.edge) {
                  setState(() {
                    offset = offset + value * 2.5;
                  });
                }
              },
              child: Container(
                child: widget.child,
                height: widget.maxHeight,
              ),
            ),
            Offstage(
              child: Container(
                ///使用图层来解决当抽屉露出头时，上拉抽屉上移。解决的方案最佳
                color: Colors.transparent,
                height: widget.maxHeight,
              ),
              offstage: _offstage,
            )
          ],
        ),
      ),
    );
  }

  double get screenH => MediaQuery.of(context).size.height;

  ///当拖拽结束时调用
  void _handleDragEnd(DragEndDetails details) {
    _onResetControllerValue = true;

    ///很重要！！！动画完毕后，controller.value = 1.0， 这里要将value的值重置为0.0，才会再次运行动画
    ///重置value的值时，会刷新UI，故这里使用[onResetControllerValue]来进行过滤。
    _animalController.value = 0.0;
    _onResetControllerValue = false;
    double start;
    double end;

    if (offset <= centerOffset) {
      ///这个判断通过，说明已经child位置超过警戒线了，需要滚动到顶部了
      start = offset;
      end = 0.0;
    } else {
      start = offset;
      end = maxOffset;
      if (widget.onBottom != null) {
        widget.onBottom();
      }
    }

    if (_isFling &&
        details != null &&
        details.velocity != null &&
        details.velocity.pixelsPerSecond != null &&
        details.velocity.pixelsPerSecond.dy < 0) {
      ///这个判断通过，说明是快速向上滑动，此时需要滚动到顶部了
      start = offset;
      end = 0.0;
    }
    _animalTo(end);
  }

  void _animalTo(double end) {
    ///easeOut 先快后慢
    final CurvedAnimation curve =
        CurvedAnimation(parent: _animalController, curve: Curves.easeOut);
    _animation = Tween(begin: offset, end: end).animate(curve)
      ..addListener(() {
        if (!_onResetControllerValue) {
          offset = _animation.value;
          setState(() {});
        }
      });

    ///自己滚动
    _animalController.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    offset = offset + details.delta.dy;
    setState(() {});
  }

  void _handleDragStart(DragStartDetails details) {
    _isFling = false;
  }
}

typedef FlingListener = void Function(bool isFling);

///MyVerticalDragGestureRecognizer 负责任务
///1.监听child的位置更新
///2.判断child在手松的那一刻是否是出于fling状态
class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  /// Create a gesture recognizer for interactions in the vertical axis.
  MyVerticalDragGestureRecognizer({Object debugOwner, this.flingListener})
      : super(debugOwner: debugOwner);

  final FlingListener flingListener;

  final Map<int, VelocityTracker> _velocityTrackers = <int, VelocityTracker>{};

  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (!event.synthesized &&
        (event is PointerDownEvent || event is PointerMoveEvent)) {
      final VelocityTracker tracker = _velocityTrackers[event.pointer];
      assert(tracker != null);
      tracker.addPosition(event.timeStamp, event.position);
    }
  }

  @override
  void addPointer(PointerEvent event) {
    super.addPointer(event);
    _velocityTrackers[event.pointer] = VelocityTracker();
  }

  ///来检测是否是fling
  @override
  void didStopTrackingLastPointer(int pointer) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? kTouchSlop;
    final VelocityTracker tracker = _velocityTrackers[pointer];

    ///VelocityEstimate 计算二维速度的
    final VelocityEstimate estimate = tracker.getVelocityEstimate();
    bool isFling = false;
    if (estimate != null && estimate.pixelsPerSecond != null) {
      isFling = estimate.pixelsPerSecond.dy.abs() > minVelocity &&
          estimate.offset.dy.abs() > minDistance;
    }
    _velocityTrackers.clear();
    if (flingListener != null) {
      flingListener(isFling);
    }

    ///super.didStopTrackingLastPointer(pointer) 会调用[_handleDragEnd]
    ///所以将[lingListener(isFling);]放在前一步调用
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void dispose() {
    _velocityTrackers.clear();
    super.dispose();
  }
}

typedef ScrollListener = void Function(
    double dragDistance, ScrollNotificationListener notification);

///监听手指在child处于边缘时的滑动
///例如：当child滚动到顶部时，此时下拉，会回调[ScrollNotificationListener.edge],
///或者child滚动到底部时，此时下拉，会回调[ScrollNotificationListener.edge],
///当child为[ScrollView]的子类时，例如：[ListView] / [GridView] 等，时，需要将其`physics`属性设置为[ClampingScrollPhysics]
///想看原因的，可以看下：
/// ///这个属性是用来断定滚动的部件的物理特性，例如：
//        ///scrollStart
//        ///ScrollUpdate
//        ///Overscroll
//        ///ScrollEnd
//        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置
//
//        /// The scroll physics to use for the platform given by [getPlatform].
//        ///
//        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
//        /// Android.
////  ScrollPhysics getScrollPhysics(BuildContext context) {
////    switch (getPlatform(context)) {
////    case TargetPlatform.iOS:/*/
////         return const BouncingScrollPhysics();
////    case TargetPlatform.android:
////    case TargetPlatform.fuchsia:
////        return const ClampingScrollPhysics();
////    }
////    return null;
////  }
///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
///故这里，设定为[ClampingScrollPhysics]
class OverscrollNotificationWidget extends StatefulWidget {
  const OverscrollNotificationWidget({
    Key key,
    @required this.child,
    this.notification,
//    this.scrollListener,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final Function(double value, ScrollNotificationListener notification)
      notification;
//  final ScrollListener scrollListener;

  @override
  OverscrollNotificationWidgetState createState() =>
      OverscrollNotificationWidgetState();
}

/// Contains the state for a [OverscrollNotificationWidget]. This class can be used to
/// programmatically show the refresh indicator, see the [show] method.
class OverscrollNotificationWidgetState
    extends State<OverscrollNotificationWidget>
    with TickerProviderStateMixin<OverscrollNotificationWidget> {
  final GlobalKey _key = GlobalKey();

  ///[ScrollStartNotification] 部件开始滑动
  ///[ScrollUpdateNotification] 部件位置发生改变
  ///[OverscrollNotification] 表示窗口小部件未更改它的滚动位置，因为更改会导致滚动位置超出其滚动范围
  ///[ScrollEndNotification] 部件停止滚动
  ///之所以不能使用这个来build或者layout，是因为这个通知的回调是会有延迟的。
  ///Any attempt to adjust the build or layout based on a scroll notification would
  ///result in a layout that lagged one frame behind, which is a poor user experience.

  @override
  Widget build(BuildContext context) {
    final Widget child = NotificationListener<ScrollStartNotification>(
      key: _key,
      child: NotificationListener<ScrollUpdateNotification>(
        child: NotificationListener<OverscrollNotification>(
          child: NotificationListener<ScrollEndNotification>(
            child: widget.child,
            onNotification: (ScrollEndNotification notification) {
              if (widget.notification != null) {
                widget.notification(0.0, ScrollNotificationListener.end);
              }
              return false;
            },
          ),
          onNotification: (OverscrollNotification notification) {
            if (notification.dragDetails != null &&
                notification.dragDetails.delta != null) {
              if (widget.notification != null) {
                widget.notification(notification.dragDetails.delta.dy,
                    ScrollNotificationListener.edge);
              }
            }
            return false;
          },
        ),
        onNotification: (ScrollUpdateNotification notification) {
          if (widget.notification != null) {
            widget.notification(notification.dragDetails?.delta?.dy,
                ScrollNotificationListener.update);
          }
          return false;
        },
      ),
      onNotification: (ScrollStartNotification scrollUpdateNotification) {
        if (widget.notification != null) {
          widget.notification(0.0, ScrollNotificationListener.start);
        }
        return false;
      },
    );

    return child;
  }
}

enum ScrollNotificationListener {
  ///滑动开始
  start,

  ///滑动结束
  end,

  ///滑动时，控件在边缘（最上面显示或者最下面显示）位置
  edge,

  ///滑动
  update,
}

/// -----------------------DEMO-----------------------
///
///
///
/// DragController controller = DragController();
//class Demo extends StatefulWidget {
//  @override
//  _DemoState createState() => _DemoState();
//}
//
//class _DemoState extends State<Demo> {
//  @override
//  Widget build(BuildContext context) {
//    return BottomDragWidget(
//        body: Container(
//          color: Colors.brown,
//          child: ListView.builder(itemBuilder: (BuildContext context, int index){
//            return Text('我是listview下面一层的东东，index=$index');
//          }, itemCount: 100,),
//        ),
//        dragContainer: DragContainer(
//          controller: controller,
//          drawer: getListView(),
//          defaultShowHeight: 150.0,
//          height: 700.0,
//        ));
//  }
//
//  Widget getListView() {
//    return Container(
//      height:600.0,
//
//      ///总高度
//      color: Colors.amberAccent,
//      child: Column(
//        children: <Widget>[
//          Container(
//            color: Colors.deepOrangeAccent,
//            height: 10.0,
//          ),
//          Expanded(child: newListView())
//        ],
//      ),
//    );
//  }
//
//  Widget newListView() {
//    return OverscrollNotificationWidget(
//      child: ListView.builder(
//        itemBuilder: (BuildContext context, int index) {
//          return Text('data=$index');
//        },
//        itemCount: 100,
//        ///这个属性是用来断定滚动的部件的物理特性，例如：
//        ///scrollStart
//        ///ScrollUpdate
//        ///Overscroll
//        ///ScrollEnd
//        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置
//
/////下面代码是我在翻源码找到的解决方案
///// The scroll physics to use for the platform given by [getPlatform].
//        ///
//        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
//        /// Android.
////  ScrollPhysics getScrollPhysics(BuildContext context) {
////    switch (getPlatform(context)) {
////    case TargetPlatform.iOS:/*/
////         return const BouncingScrollPhysics();
////    case TargetPlatform.android:
////    case TargetPlatform.fuchsia:
////        return const ClampingScrollPhysics();
////    }
////    return null;
////  }
//        ///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
//        ///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
//        ///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
//        ///故这里，设定为[ClampingScrollPhysics]
//        physics: const ClampingScrollPhysics(),
//      ),
//      scrollListener: _scrollListener,
//    );
//  }
//
//  void _scrollListener(
//      double dragDistance, ScrollNotificationListener isDragEnd) {
//    controller.updateDragDistance(dragDistance, isDragEnd);
//  }
//}
///
