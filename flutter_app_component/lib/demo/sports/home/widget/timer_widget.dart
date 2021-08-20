import 'dart:async';

import 'package:flutter/widgets.dart';

const int kDefaultAutoplayDelayMs = 3000;

/// @author jd
class TimerWidget extends StatefulWidget {
  const TimerWidget({
    @required this.builder,
    this.autoplayDelay = kDefaultAutoplayDelayMs,
    this.maxIndex = 10,
  });

  final IndexedWidgetBuilder builder;
  final int autoplayDelay;
  final int maxIndex;
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer _timer;
  int _currentIndex = 0;
  Widget _child;

  @override
  void initState() {
    if (widget.builder != null) {
      _child = widget.builder(context, _currentIndex);
      _startAutoplay();
    }
    super.initState();
  }

  @override
  void dispose() {
    _stopAutoplay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _child ?? Container();
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _startAutoplay() {
    assert(_timer == null, 'Timer must be stopped before start!');
    _currentIndex = 1;
    _timer =
        Timer.periodic(Duration(milliseconds: widget.autoplayDelay), _onTimer);
  }

  void _onTimer(Timer timer) {
    if (widget.builder != null) {
      _child = widget.builder(context, _currentIndex);
      setState(() {});
      _currentIndex++;
      if (_currentIndex >= widget.maxIndex) {
        _currentIndex = 0;
      }
    }
  }
}
