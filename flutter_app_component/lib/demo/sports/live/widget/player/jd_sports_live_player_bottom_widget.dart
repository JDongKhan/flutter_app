import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/demo/thirdpary/player/jd_player.dart';
import 'package:provider/provider.dart';

import '../../jd_sports_live_controller.dart';

/// @author jd

class JDSportsLivePlayerBottomController extends ChangeNotifier {
  JDSportsLivePlayerBottomController({
    @required this.playerController,
  });
  Duration _position, _duration;

  final JDPlayerController playerController;

  void changeDuration(Duration position, Duration duration) {
    _position = position;
    _duration = duration;
    notifyListeners();
  }
}

class JDSportsLivePlayerBottomWidget extends StatefulWidget {
  const JDSportsLivePlayerBottomWidget({
    @required this.controller,
  });
  final JDSportsLivePlayerBottomController controller;
  @override
  _JDSportsLivePlayerBottomWidgetState createState() =>
      _JDSportsLivePlayerBottomWidgetState();
}

class _JDSportsLivePlayerBottomWidgetState
    extends State<JDSportsLivePlayerBottomWidget> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomWidget();
  }

  Widget _buildBottomWidget() {
    return Container(
      height: 40,
      child: Row(
        children: [
          _buildPlayOrNotWidget(),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              duration_toString(widget.controller._position),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
                value: _getValueFromDuration(),
                backgroundColor: Colors.greenAccent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
          ),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              duration_toString(widget.controller._duration),
              style: TextStyle(color: Colors.white),
            ),
          ),
          _buildFullWidget(),
        ],
      ),
    );
  }

  Widget _buildPlayOrNotWidget() {
    if (widget.controller.playerController.isPlaying) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.controller.playerController.pause();
        },
        child: Icon(
          Icons.pause_circle_outline_rounded,
          color: Colors.white,
          size: 30,
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.controller.playerController.play();
      },
      child: Icon(
        Icons.play_circle_outline_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildFullWidget() {
    JDSportsLiveController controller = context.watch<JDSportsLiveController>();
    if (controller.orientation == Orientation.landscape) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          Future.delayed(Duration(seconds: 1), () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          });
        },
        child: Icon(
          Icons.fullscreen_exit_rounded,
          size: 30,
          color: Colors.white,
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
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
      },
      child: Icon(
        Icons.fullscreen_rounded,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  double _getValueFromDuration() {
    if (widget.controller._position == null) {
      return 0.0;
    }
    double d = widget.controller._position.inSeconds /
        widget.controller._duration.inSeconds;
    return d;
  }

  String duration_toString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    if (duration == null) {
      return '00:00';
    }

    String twoDigitSeconds = twoDigits(
        duration.inSeconds.remainder(Duration.secondsPerMinute) as int);

    if (duration.inMicroseconds < 0) {
      return "${twoDigitSeconds}";
    }

    String twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour) as int);

    if (duration.inHours <= 0) {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }

    String twoHours = '${duration.inHours}';
    return '${twoHours}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
