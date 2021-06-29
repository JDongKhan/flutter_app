import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

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
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              _handelNotification(notification);
            },
            child: widget.foregroundWidget,
          ),
        ),
      ],
    );
  }

  void _handelNotification(notification) {
    switch (notification.runtimeType) {
      case ScrollNotification:
        print('ScrollNotification');
        break;
      case ScrollUpdateNotification:
        print('ScrollUpdateNotification');
        break;
      case ScrollStartNotification:
        _startScroll = true;
        print('ScrollStartNotification');
        break;
      case ScrollEndNotification:
        _startScroll = false;
        print('ScrollEndNotification');
        break;
      case OverscrollNotification:
        OverscrollNotification n = notification;
        setState(() {
          _dy = n.overscroll;
        });
        print(notification);
        // print(n.dragDetails.primaryDelta);

        break;
      case LayoutChangedNotification:
        print('LayoutChangedNotification');
        break;
      case SizeChangedLayoutNotification:
        print('SizeChangedLayoutNotification');
        break;
      case UserScrollNotification:
        print('UserScrollNotification');
        break;
      case KeepAliveNotification:
        print('KeepAliveNotification');
        break;
    }
  }
}

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
              itemCount: 50,
              itemBuilder: (context, index) {
                return Text('$index');
              }),
        ),
      ),
    );
  }
}
