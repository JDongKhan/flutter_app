import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../sports_live_player_widget.dart';

/// @author jd

class SportsLiveLandscapeWidget extends SportsLivePlayerWidget {
  @override
  _SportsLiveLandscapeWidgetState createState() =>
      _SportsLiveLandscapeWidgetState();
}

class _SportsLiveLandscapeWidgetState extends SportsLivePlayerWidgetState {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    Future.delayed(Duration(seconds: 1), () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Orientation screenOrientation() {
    return Orientation.portrait;
  }
}
