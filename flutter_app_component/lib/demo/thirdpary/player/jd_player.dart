import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// @author jd

class JDPlayer extends StatefulWidget {
  JDPlayer({@required this.url});
  final String url;
  @override
  _JDPlayerState createState() => _JDPlayerState();
}

class _JDPlayerState extends State<JDPlayer> {
  VideoPlayerController _videoPlayerController;
  bool _isPlaying;
  @override
  void initState() {
    super.initState();
    Function listener = () {
      if (!mounted) {
        return;
      }
      final bool isPlaying = _videoPlayerController.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
        });
      }
    };
    _videoPlayerController = VideoPlayerController.asset(widget.url)
      ..initialize().then((value) {
        setState(() {});
      });
    _videoPlayerController.addListener(listener);
    _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_videoPlayerController);
  }
}
