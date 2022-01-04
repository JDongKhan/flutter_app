import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/component/drag_progress_bar.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../vm/sports_live_controller.dart';

/// @author jd

class SportsLivePlayerBottomWidget extends StatefulWidget {
  const SportsLivePlayerBottomWidget({
    @required this.playerController,
  });
  final VideoPlayerController playerController;
  @override
  _SportsLivePlayerBottomWidgetState createState() =>
      _SportsLivePlayerBottomWidgetState();
}

class _SportsLivePlayerBottomWidgetState
    extends State<SportsLivePlayerBottomWidget> {
  final SportsLiveController _sportsLiveController =
      Get.find<SportsLiveController>();

  double _tempSeekValue = 0;
  @override
  void initState() {
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
            child: Obx(
              () => Text(
                durationToString(_sportsLiveController.position.value),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => DragProgressBar(
                value: _getValueFromDuration(),
                inactiveColor: Colors.grey,
                activeColor: Colors.white,
                onPanStart: () {},
                onPanEnd: () {
                  widget.playerController
                      .seekTo(_seek_toDuration(_tempSeekValue));
                },
                onPanChanged: (double value) {
                  _tempSeekValue = value;
                },
              ),
            ),
          ),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                durationToString(_sportsLiveController.duration.value),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          _buildFullWidget(),
        ],
      ),
    );
  }

  Widget _buildPlayOrNotWidget() {
    if (widget.playerController.value.isPlaying) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.playerController.pause();
        },
        child: const Icon(
          Icons.pause,
          color: Colors.white,
          size: 28,
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.playerController.play();
      },
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget _buildFullWidget() {
    SportsLiveController controller = Get.find<SportsLiveController>();
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
    final double durationMilliseconds =
        _sportsLiveController.duration.value.inMilliseconds.toDouble();
    final int position = (durationMilliseconds * value).toInt();
    final Duration duration = Duration(milliseconds: position);
    return duration;
  }

  double _getValueFromDuration() {
    if (_sportsLiveController.position == null) {
      return 0.0;
    }
    int positionSeconds = _sportsLiveController.position.value.inSeconds;
    if (positionSeconds == 0) {
      return 0.0;
    }
    double d = _sportsLiveController.position.value.inSeconds /
        _sportsLiveController.duration.value.inSeconds;
    return d;
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    if (duration == null) {
      return '00:00';
    }

    final String twoDigitSeconds = twoDigits(
        duration.inSeconds.remainder(Duration.secondsPerMinute) as int);

    if (duration.inMicroseconds < 0) {
      return twoDigitSeconds;
    }

    final String twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour) as int);

    if (duration.inHours <= 0) {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }

    final String twoHours = '${duration.inHours}';
    return '$twoHours:$twoDigitMinutes:$twoDigitSeconds';
  }
}
