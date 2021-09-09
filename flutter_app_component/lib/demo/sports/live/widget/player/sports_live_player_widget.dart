import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/demo/thirdpary/player/player.dart';
import 'package:get/get.dart';
import 'package:jd_core/widget/orientation/orientation_observer.dart';

import '../../vm/sports_live_controller.dart';
import 'sports_live_player_bottom_widget.dart';
import 'sports_live_player_top_widget.dart';

/// @author jd

class SportsLivePlayerWidget extends StatefulWidget {
  const SportsLivePlayerWidget({
    Key key,
    @required this.url,
  }) : super(key: key);
  final String url;
  @override
  SportsLivePlayerWidgetState createState() => SportsLivePlayerWidgetState();
}

class SportsLivePlayerWidgetState extends State<SportsLivePlayerWidget>
    with TickerProviderStateMixin {
  PlayerController _playerController;
  AnimationController _animationController;
  Animation _slideTopAnimation, _slideBottomAnimation, _slideRightAnimation;
  bool _isShowMenuAnimal = false;
  bool _isLocked = false;

  final SportsLiveController _sportsLiveController =
      Get.find<SportsLiveController>();
  @override
  void initState() {
    _playerController = PlayerController(initPlaying: true, url: widget.url);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _slideTopAnimation = Tween(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(_animationController);
    _slideBottomAnimation = Tween(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _slideRightAnimation = Tween(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);

    showMenu();

    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void showMenu({bool immediately}) {
    if (_isShowMenuAnimal) return;
    Future.delayed(const Duration(seconds: 0), () {
      if (!mounted) return;
      _isShowMenuAnimal = true;
      _animationController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      dissmisMenu();
    });
  }

  void dissmisMenu() {
    if (!mounted) {
      return;
    }
    _animationController.reverse();
    _isShowMenuAnimal = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Player(
            controller: _playerController,
            onTap: () {
              if (_isLocked) return;
              showMenu();
            },
            onChange: (position, duration) {
              _sportsLiveController.changeDuration(position, duration);
              // _bottomController.changeDuration(position, duration);
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
              top: 0,
              bottom: 0,
              child: Center(child: _buildLockWidget()),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SlideTransition(
                position: _slideTopAnimation,
                child: SportsLivePlayerTopWidget(),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 8,
              right: 8,
              child: SlideTransition(
                position: _slideBottomAnimation,
                child: SportsLivePlayerBottomWidget(
                    playerController: _playerController),
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
        SportsLiveController controller = Get.find<SportsLiveController>();
        if (controller.orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          OrientationObserver.reset(context);
          return;
        }
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLockWidget() {
    SportsLiveController controller = Get.find<SportsLiveController>();
    if (controller.orientation == Orientation.portrait) {
      return Container();
    }
    return _isLocked
        ? IconButton(
            icon: const Icon(Icons.lock_outline, size: 20, color: Colors.white),
            onPressed: () {
              setState(() {
                _isLocked = false;
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              });
            },
          )
        : IconButton(
            icon: const Icon(Icons.lock_open_outlined,
                size: 20, color: Colors.white),
            onPressed: () {
              setState(() {
                _isLocked = true;
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
                dissmisMenu();
              });
            },
          );
  }

  Widget _buildRightMenuWidget() {
    return Container(
      width: 40,
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.games,
            size: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
