import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/vm/sports_home_video_vm.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player.dart';
import 'package:jd_core/jd_core.dart';
import 'package:provider/provider.dart';

/// @author jd

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

class _SportsListPlayerState extends State<SportsListPlayer> {
  PlayerController _playerController;
  bool _playing = false;
  @override
  void initState() {
    _playerController =
        PlayerController(initPlaying: true, url: widget.videoUrl);
    _playerController.addListener(_listener);
    _playing = widget.playing;
    super.initState();
  }

  @override
  void dispose() {
    _clearController();
    super.dispose();
  }

  void _clearController() {
    if (_playerController != null) {
      _playerController.dispose();
      _playerController = null;
    }
  }

  @override
  void didUpdateWidget(covariant SportsListPlayer oldWidget) {
    _clearController();
    _playerController =
        PlayerController(initPlaying: true, url: widget.videoUrl);
    _playerController.addListener(_listener);
    _playing = widget.playing;
    super.didUpdateWidget(oldWidget);
  }

  void _listener() {
    if (_playing != _playerController.isPlaying) {
      setState(() {
        _playing = _playerController.isPlaying;
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
    SportsHomeVideoVM vm = context.read<SportsHomeVideoVM>();
    if (_playing) {
      vm.playingPlayerController = _playerController;
    }
    return _playing
        ? Container(
            child: Player(
              controller: _playerController,
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
                    vm.toPlay(_playerController);
                    // _playerController.play();
                  },
                ),
              ],
            ),
          );
  }
}
