import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_component/demo/sports/home/vm/player_manager.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player.dart';
import 'package:jd_core/jd_core.dart';
import 'package:lifecycle/lifecycle.dart';

/// @author jd

class SportsListPlayerController extends ChangeNotifier {
  SportsListPlayerController({
    this.videoUrl,
    this.playing,
  }) : playerController = PlayerController(initPlaying: true, url: videoUrl);

  PlayerController playerController;
  final String videoUrl;
  bool playing;

  void play() {
    playing = true;
    notifyListeners();
    playerController.play();
  }

  void pause() {
    playing = false;
    playerController.pause();
    notifyListeners();
  }

  @override
  void dispose() {
    if (playerController != null) {
      playerController.dispose();
    }
    super.dispose();
  }
}

class SportsListPlayer extends StatefulWidget {
  const SportsListPlayer({
    this.videoUrl,
    this.playing = false,
    this.cover,
  });
  final String videoUrl;
  final bool playing;
  final String cover;
  @override
  _SportsListPlayerState createState() => _SportsListPlayerState();
}

class _SportsListPlayerState extends State<SportsListPlayer>
    with LifecycleAware, LifecycleMixin {
  SportsListPlayerController _sportsListPlayerController;
  bool _playing = false;
  @override
  void initState() {
    _sportsListPlayerController = SportsListPlayerController(
        videoUrl: widget.videoUrl, playing: widget.playing);
    _sportsListPlayerController.addListener(_listener);
    _playing = widget.playing;
    super.initState();
  }

  @override
  void dispose() {
    _clearController();
    super.dispose();
  }

  void _clearController() {
    if (_sportsListPlayerController != null) {
      _sportsListPlayerController.dispose();
      _sportsListPlayerController = null;
    }
  }

  @override
  void didUpdateWidget(covariant SportsListPlayer oldWidget) {
    _clearController();
    _sportsListPlayerController = SportsListPlayerController(
        videoUrl: widget.videoUrl, playing: widget.playing);
    _sportsListPlayerController.addListener(_listener);
    _playing = widget.playing;
    super.didUpdateWidget(oldWidget);
  }

  void _listener() {
    if (_playing != _sportsListPlayerController.playing) {
      setState(() {
        _playing = _sportsListPlayerController.playing;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('SportsListPlayer-playing:$_playing');
    if (_playing) {
      playerManaer.sportsListPlayerController = _sportsListPlayerController;
    }
    return _playing
        ? Container(
            child: Player(
              controller: _sportsListPlayerController.playerController,
            ),
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
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        playerManaer.to(_sportsListPlayerController);
      });
    } else if (event == LifecycleEvent.visible) {
    } else if (event == LifecycleEvent.active) {
    } else if (event == LifecycleEvent.inactive) {
    } else if (event == LifecycleEvent.invisible) {
    } else if (event == LifecycleEvent.pop) {}
  }
}
