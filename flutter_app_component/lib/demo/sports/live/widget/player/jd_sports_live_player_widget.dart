import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/demo/thirdpary/player/jd_player.dart';
import 'package:provider/provider.dart';

import '../../jd_sports_live_controller.dart';
import 'jd_sports_live_player_bottom_widget.dart';
import 'jd_sports_live_player_top_widget.dart';

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

class JDSportsLivePlayerWidgetState extends State<JDSportsLivePlayerWidget>
    with TickerProviderStateMixin {
  JDPlayerController _playerController = JDPlayerController();
  JDSportsLivePlayerBottomController _bottomController;
  AnimationController _animationController;
  Animation _slideTopAnimation, _slideBottomAnimation, _slideRightAnimation;
  @override
  void initState() {
    _bottomController =
        JDSportsLivePlayerBottomController(playerController: _playerController);
    _bottomController.addListener(() {});

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideTopAnimation = Tween(
      begin: Offset(0, -2),
      end: Offset(0, 0),
    ).animate(_animationController);
    _slideBottomAnimation = Tween(
      begin: Offset(0, 2),
      end: Offset(0, 0),
    ).animate(_animationController);

    _slideRightAnimation = Tween(
      begin: Offset(2, 0),
      end: Offset(0, 0),
    ).animate(_animationController);

    showMenu();

    super.initState();
  }

  @override
  void dispose() {
    _bottomController.dispose();
    _playerController.dispose();
    super.dispose();
  }

  void showMenu({bool immediately}) {
    Future.delayed(Duration(seconds: 0), () {
      _animationController.forward();
    });

    Future.delayed(Duration(seconds: 2), () {
      dissmisMenu();
    });
  }

  void dissmisMenu() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          JDPlayer(
            url: widget.url,
            controller: _playerController,
            onTap: () {
              showMenu();
            },
            onChange: (position, duration) {
              _bottomController.changeDuration(position, duration);
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
            Positioned(
              left: 0,
              top: 0,
              child: _buildBackWidget(),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SlideTransition(
                position: _slideTopAnimation,
                child: JDSportsLivePlayerTopWidget(),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 8,
              right: 8,
              child: SlideTransition(
                position: _slideBottomAnimation,
                child: JDSportsLivePlayerBottomWidget(
                    controller: _bottomController),
              ),
            ),
            Positioned(
              top: 0,
              right: 12,
              bottom: 0,
              child: SlideTransition(
                position: _slideRightAnimation,
                child: _buildRightMenuWidget(),
              ),
            ),
          ],
        ));
  }

  Widget _buildBackWidget() {
    return IconButton(
      onPressed: () {
        JDSportsLiveController controller =
            context.read<JDSportsLiveController>();
        if (controller.orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          Future.delayed(Duration(seconds: 1), () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          });
          return;
        }
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRightMenuWidget() {
    return Container(
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
    );
  }
}
