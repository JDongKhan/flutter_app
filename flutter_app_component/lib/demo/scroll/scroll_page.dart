import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class SrcollPage extends StatefulWidget {
  @override
  _SrcollPageState createState() => _SrcollPageState();
}

class _SrcollPageState extends State<SrcollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SrcollPage'),
      ),
      body: ScrollPageWidget(
        backgroundWidget:
            Container(color: Colors.red, child: Text('background')),
        foregroundWidget: Container(
          color: Colors.blue,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics()),
              itemCount: 100,
              itemBuilder: (context, index) {
                return Text('$index');
              }),
        ),
      ),
    );
  }
}

class ScrollPageWidget extends StatefulWidget {
  const ScrollPageWidget({
    Key key,
    this.backgroundWidget,
    this.foregroundWidget,
  }) : super(key: key);
  final Widget backgroundWidget;
  final Widget foregroundWidget;

  @override
  _ScrollPageWidgetState createState() => _ScrollPageWidgetState();
}

class _ScrollPageWidgetState extends State<ScrollPageWidget> {
  bool _startScroll = false;
  double _dy = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: widget.backgroundWidget,
        ),
        Positioned(
          top: -_dy,
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildListener1Widget(),
        ),
      ],
    );
  }

  Widget _buildListener1Widget() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _handelNotification(notification);
      },
      child: widget.foregroundWidget,
    );
  }

  Widget _buildListener2Widget() {
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {MyVerticalDragGestureRecognizer: getRecognizer()},
      child: widget.foregroundWidget,
    );
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>
      getRecognizer() {
    return GestureRecognizerFactoryWithHandlers<
        MyVerticalDragGestureRecognizer>(
      () => MyVerticalDragGestureRecognizer(), //constructor
      (MyVerticalDragGestureRecognizer instance) {
        //initializer
        instance
          ..onStart = _handleDragStart
          ..onUpdate = _handleDragUpdate
          ..onEnd = _handleDragEnd;
      },
    );
  }

  void _handleDragStart(DragStartDetails details) {
    print('_handleDragStart:$details');
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    print('_handleDragUpdate:$details');
    _dy += details.delta.dy;
    setState(() {});
  }

  void _handleDragEnd(DragEndDetails details) {
    print('_handleDragEnd:$details');
    _dy = 0;
    setState(() {});
  }

  void _handelNotification(Notification notification) {
    switch (notification.runtimeType) {
      case ScrollNotification:
        debugPrint('ScrollNotification');
        break;
      case ScrollUpdateNotification:
        debugPrint('ScrollUpdateNotification');
        break;
      case ScrollStartNotification:
        _startScroll = true;
        debugPrint('ScrollStartNotification');
        break;
      case ScrollEndNotification:
        _startScroll = false;
        debugPrint('ScrollEndNotification');
        setState(() {
          // _dy += -n.dragDetails.delta.dy;
          _dy = 0;
        });
        break;
      case OverscrollNotification:
        debugPrint('OverscrollNotification');
        OverscrollNotification n = notification;
        setState(() {
          // _dy += -n.dragDetails.delta.dy;
          _dy += n.overscroll;
        });
        debugPrint(notification.toString());
        // print(n.dragDetails.primaryDelta);

        break;
      case LayoutChangedNotification:
        debugPrint('LayoutChangedNotification');
        break;
      case SizeChangedLayoutNotification:
        debugPrint('SizeChangedLayoutNotification');
        break;
      case UserScrollNotification:
        debugPrint('UserScrollNotification');
        break;
      case KeepAliveNotification:
        debugPrint('KeepAliveNotification');
        break;
    }
  }
}

class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
  }
  //
  // @override
  // bool isPointerAllowed(PointerEvent event) {
  //   return false;
  // }

  @override
  void addPointer(PointerEvent event) {
    super.addPointer(event);
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    super.didStopTrackingLastPointer(pointer);
  }
}
