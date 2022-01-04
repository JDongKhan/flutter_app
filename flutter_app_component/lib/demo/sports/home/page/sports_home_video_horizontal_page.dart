import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player.dart';
import 'package:video_player/video_player.dart';

/// @author jd

class SportsHomeVideoHorizontalPage extends StatefulWidget {
  const SportsHomeVideoHorizontalPage(this.playerController);
  final VideoPlayerController playerController;
  @override
  _SportsHomeVideoHorizontalPageState createState() =>
      _SportsHomeVideoHorizontalPageState();
}

class _SportsHomeVideoHorizontalPageState
    extends State<SportsHomeVideoHorizontalPage> {
  final GlobalKey _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Player(
              key: _globalKey,
              autoPlay: true,
              debugLabel: 'horizontal',
              controller: widget.playerController,
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 1), () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
