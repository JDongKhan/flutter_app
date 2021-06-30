import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'jd_player.dart';

/// @author jd
class JDPlayerDemoPage extends StatefulWidget {
  @override
  _JDPlayerDemoPageState createState() => _JDPlayerDemoPageState();
}

class _JDPlayerDemoPageState extends State<JDPlayerDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('播放器'),
      ),
      body: JDPlayer(
        url: 'assets/videos/video_1.mp4',
      ),
    );
  }
}
