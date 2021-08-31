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
    SportsHomeVideoVM vm = context.watch<SportsHomeVideoVM>();
    bool isPlaying = vm.isPlaying;
    if (vm.playingState != this) {
      isPlaying = false;
    } else {
      isPlaying = true;
    }
    return isPlaying
        ? Container(
            child: Player(
              controller: PlayerController(initPlaying: true),
              url: widget.videoUrl,
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
                    setState(() {
                      vm.play(this);
                    });
                  },
                ),
              ],
            ),
          );
  }
}
