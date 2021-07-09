import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../jd_sports_live_player_widget.dart';

/// @author jd

class JDSportsLiveLandscapeWidget extends JDSportsLivePlayerWidget {
  @override
  _JDSportsLiveLandscapeWidgetState createState() =>
      _JDSportsLiveLandscapeWidgetState();
}

class _JDSportsLiveLandscapeWidgetState extends JDSportsLivePlayerWidgetState {
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
