import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/component/drag_progress_bar.dart';
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
  bool _isPanStart = false;
  double _tempSeekValue = 0;
  @override
  void initState() {
    widget.controller.addListener(() {
      if (_isPanStart) return;
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
            margin: const EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              duration_toString(widget.controller._position),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: DragProgressBar(
              value: _getValueFromDuration(),
              inactiveColor: Colors.grey,
              activeColor: Colors.white,
              onPanStart: () {
                _isPanStart = true;
              },
              onPanEnd: () {
                _isPanStart = false;
                widget.controller.playerController
                    .seek(_seek_toDuration(_tempSeekValue));
              },
              onPanChanged: (double value) {
                _tempSeekValue = value;
              },
            ),
          ),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              duration_toString(widget.controller._duration),
              style: const TextStyle(color: Colors.white),
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
        child: const Icon(
          Icons.pause_circle_outline_rounded,
          color: Colors.white,
          size: 28,
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.controller.playerController.play();
      },
      child: const Icon(
        Icons.play_circle_outline_rounded,
        color: Colors.white,
        size: 28,
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
          Future.delayed(const Duration(seconds: 1), () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          });
        },
        child: const Icon(
          Icons.fullscreen_exit_rounded,
          size: 28,
          color: Colors.white,
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        Future.delayed(const Duration(seconds: 1), () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        });
      },
      child: const Icon(
        Icons.fullscreen_rounded,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  Duration _seek_toDuration(double value) {
    double durationMilliseconds =
        widget.controller._duration.inMilliseconds.toDouble();
    int position = (durationMilliseconds * value).toInt();
    Duration duration = Duration(milliseconds: position);
    return duration;
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
