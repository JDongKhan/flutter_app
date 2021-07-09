import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/thirdpary/player/jd_player.dart';

import 'jd_sports_live_player_bottom_widget.dart';

/// @author jd

class JDSportsLivePlayerWidget extends StatefulWidget {
  const JDSportsLivePlayerWidget({
    Key key,
    @required this.url,
  }) : super(key: key);
  final String url;
  @override
  JDSportsLivePlayerWidgetState createState() =>
      JDSportsLivePlayerWidgetState();
}

class JDSportsLivePlayerWidgetState extends State<JDSportsLivePlayerWidget> {
  JDPlayerController _playerController = JDPlayerController();
  JDSportsLivePlayerBottomController _bottomController;

  @override
  void initState() {
    _bottomController =
        JDSportsLivePlayerBottomController(playerController: _playerController);
    _bottomController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _bottomController.dispose();
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          JDPlayer(
            url: widget.url,
            controller: _playerController,
            onChange: (position, duration) {
              _bottomController.changeDuration(position, duration);
              // setState(() {
              //   _position = position;
              //   _duration = duration;
              // });
            },
          ),
          _buildTopMenuWidget(),
        ],
      ),
    );
  }

  Widget _buildTopMenuWidget() {
    return SafeArea(
        bottom: false,
        child: Stack(
          children: [
            _buildBackWidget(),
            _buildRightActionWidget(),
            JDSportsLivePlayerBottomWidget(controller: _bottomController),
            _buildRightMenuWidget(),
          ],
        ));
  }

  Widget _buildBackWidget() {
    return Positioned(
      left: 0,
      top: 0,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRightActionWidget() {
    return Positioned(
      right: 0,
      top: 0,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.tv,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightMenuWidget() {
    return Positioned(
      top: 0,
      right: 12,
      bottom: 0,
      child: Container(
        width: 40,
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.airplay,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
