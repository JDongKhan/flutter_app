import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/vm/player_manager.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player.dart';
import 'package:jd_core/jd_core.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

class SportsListPlayerController {
  SportsListPlayerController({
    this.videoUrl,
    this.looping = true,
  });

  final String videoUrl;
  bool looping;
  VideoPlayerController videoPlayerController;

  void prepare() {
    if (videoPlayerController == null) {
      videoPlayerController = VideoPlayerController.asset(videoUrl);
      videoPlayerController.setLooping(looping);
    }
  }

  void play() {
    debugPrint('$videoUrl - 主动调用了play');
    videoPlayerController?.play();
  }

  void pause() {
    debugPrint('$videoUrl - 主动调用了pause');
    videoPlayerController?.pause();
  }

  void reset() {
    // videoPlayerController?.dispose();
    // videoPlayerController = null;
  }

  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController.dispose();
    }
  }
}

class SportsListPlayer extends StatefulWidget {
  const SportsListPlayer({
    this.videoUrl,
    this.playing = false,
    this.cover,
    this.sportsListPlayerController,
    this.debugLabel = 'listPlayer',
  });
  final String videoUrl;
  final bool playing;
  final String cover;
  final SportsListPlayerController sportsListPlayerController;
  final String debugLabel;
  @override
  _SportsListPlayerState createState() => _SportsListPlayerState();
}

class _SportsListPlayerState extends State<SportsListPlayer>
    with LifecycleAware, LifecycleMixin {
  SportsListPlayerController _sportsListPlayerController;
  bool _playing = false;
  bool _visiable = true;
  @override
  void initState() {
    _sportsListPlayerController = widget.sportsListPlayerController;
    _playing = widget.playing;
    debugPrint(
        'SportsListPlayer[${widget.debugLabel}]-[${_sportsListPlayerController.videoUrl}]-init playing:$_playing');
    _play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SportsListPlayer oldWidget) {
    _sportsListPlayerController = widget.sportsListPlayerController;
    _playing = widget.playing;
    debugPrint(
        'SportsListPlayer[${widget.debugLabel}]-[${_sportsListPlayerController.videoUrl}]-init playing:$_playing');
    _play();
    super.didUpdateWidget(oldWidget);
  }

  void _listener() {
    debugPrint(
        'SportsListPlayer[${widget.debugLabel}]-[${_sportsListPlayerController.videoUrl}]-listener playing:$_playing c.playing:${_sportsListPlayerController.videoPlayerController?.value?.isPlaying}');

    bool p =
        _sportsListPlayerController.videoPlayerController?.value?.isPlaying ??
            false;

    if (_playing != p) {
      setState(() {
        _playing =
            _sportsListPlayerController.videoPlayerController?.value?.isPlaying;
      });
    }
  }

  void _play() {
    debugPrint(
        'SportsListPlayer[${widget.debugLabel}]-[${_sportsListPlayerController.videoUrl}]-playing:$_playing');
    if (_playing && _visiable) {
      _sportsListPlayerController.prepare();
      _sportsListPlayerController.videoPlayerController.addListener(_listener);
      playerManaer.to(_sportsListPlayerController);
    }
  }

  void _pause() {
    _sportsListPlayerController?.pause();
    _sportsListPlayerController?.videoPlayerController
        ?.removeListener(_listener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _playing && _visiable
        ? Stack(
            children: [
              Container(
                child: Player(
                  autoPlay: true,
                  debugLabel: 'list',
                  controller: _sportsListPlayerController.videoPlayerController,
                  loadFuture: _sportsListPlayerController.videoPlayerController
                      .initialize(),
                ),
              ),
              // Container(
              //   alignment: Alignment.bottomRight,
              //   child: IconButton(
              //     onPressed: () {
              //       setState(() {
              //         _visiable = false;
              //       });
              //       Get.to(
              //         () => SportsHomeVideoHorizontalPage(
              //             _sportsListPlayerController.videoPlayerController),
              //         transition: Transition.noTransition,
              //       );
              //       // 不知道为啥下面的代码就导致转屏失败
              //       // Navigator.of(context).push(
              //       //   PageAnimationBuilder.noAnim(
              //       //       SportsHomeVideoHorizontalPage(
              //       //           _sportsListPlayerController
              //       //               .videoPlayerController),
              //       //       null),
              //       // );
              //     },
              //     icon: const Icon(
              //       Icons.fullscreen,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          )
        : Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  JDAssetBundle.getImgPath(widget.cover),
                  fit: BoxFit.fitWidth,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    _sportsListPlayerController.prepare();
                    _sportsListPlayerController.videoPlayerController
                        .addListener(_listener);
                    playerManaer.to(_sportsListPlayerController);
                    // _playerController.play();
                  },
                ),
              ],
            ),
          );
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.push) {
      _visiable = true;
    } else if (event == LifecycleEvent.visible) {
      setState(() {
        _visiable = true;
        _play();
      });
    } else if (event == LifecycleEvent.active) {
      _visiable = true;
    } else if (event == LifecycleEvent.inactive) {
      _visiable = false;
    } else if (event == LifecycleEvent.invisible) {
      _visiable = false;
    } else if (event == LifecycleEvent.pop) {
      _visiable = false;
    }
  }
}
