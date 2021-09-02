import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'player.dart';

/// @author jd
class PlayerDemoPage extends StatefulWidget {
  @override
  _PlayerDemoPageState createState() => _PlayerDemoPageState();
}

class _PlayerDemoPageState extends State<PlayerDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('播放器'),
      ),
      body: Player(
        controller: PlayerController(url: 'assets/videos/video_1.mp4'),
      ),
    );
  }
}
