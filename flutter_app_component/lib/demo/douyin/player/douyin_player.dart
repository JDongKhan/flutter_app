import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/component/tabbar_view/tabbar_life_cycle.dart';
import 'package:flutter_app_component/utils/logger_util.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

class DouyinPlayerController extends ChangeNotifier {
  DouyinPlayerController(bool playing) : _playing = playing;

  bool _playing;

  void pause() {
    _playing = false;
    notifyListeners();
  }

  void play() {
    _playing = true;
    notifyListeners();
  }
}

class DouyinPlayer extends StatefulWidget {
  const DouyinPlayer({
    this.url,
    this.loop = true,
    this.source,
    this.douyinPlayerController,
  });
  final String url;
  final bool loop;
  final String source;
  final DouyinPlayerController douyinPlayerController;
  @override
  _DouyinPlayerState createState() => _DouyinPlayerState();
}

class _DouyinPlayerState extends State<DouyinPlayer>
    with
        WidgetsBindingObserver,
        LifecycleAware,
        LifecycleMixin,
        TabBarLifecycle {
  VideoPlayerController _videoPlayerController;
  bool _isPlaying;
  Future _videoPlayerFuture;
  @override
  void initState() {
    super.initState();
    logger.d('(${widget.url}) - player initState');
    WidgetsBinding.instance.addObserver(this);
    if (widget.douyinPlayerController != null) {
      widget.douyinPlayerController.addListener(() {
        if (widget.douyinPlayerController._playing == true) {
          _play();
        } else {
          _pause();
        }
      });

      Function callBack;
      if (widget.douyinPlayerController._playing) {
        callBack = () {
          _play();
        };
      }
      _prepare(callBack);
    } else {
      //准备
      _prepare(() {
        _play();
      });
    }
  }

  @override
  void dispose() {
    logger.d('(${widget.url}) - player dispose');
    _videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    logger.d('(${widget.url}) - player didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DouyinPlayer oldWidget) {
    logger.d('(${widget.url}) - player didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    logger.d('(${widget.url}) - player deactivate');
    super.deactivate();
  }

  @override
  void didChangeMetrics() {
    logger.d('(${widget.url}) - player didChangeMetrics');
  }

  @override
  Future<bool> didPushRoute(String route) {
    logger.d('(${widget.url}) - player didPushRoute');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    logger.d('(${widget.url}) - player didPopRoute');
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.d('(${widget.url}) - player didChangeAppLifecycleState');
  }

  void _listener() {
    if (!mounted) {
      return;
    }
    final bool isPlaying = _videoPlayerController.value.isPlaying;
    if (isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    }
  }

  void _prepare(Function callback) {
    _videoPlayerController = VideoPlayerController.asset(widget.url);
    _videoPlayerFuture = _videoPlayerController.initialize().then((value) {
      if (callback != null) {
        callback();
      }
    });
    _videoPlayerController.setLooping(widget.loop);
    _videoPlayerController.addListener(_listener);
  }

  void _play() {
    _videoPlayerController.play();
    if (mounted) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _pause() {
    _videoPlayerController.pause();
    if (mounted) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _stop() {}

  @override
  Widget build(BuildContext context) {
    logger.d('(${widget.url}) - build');
    return FutureBuilder(
      future: _videoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final bool isPlaying = _videoPlayerController.value.isPlaying;
              if (isPlaying) {
                _pause();
              } else {
                _play();
              }
            },
            child: Stack(
              children: [
                VideoPlayer(_videoPlayerController),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isPlaying ? 0 : 1.0,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _prepare(() {
              _play();
            });
          },
          child: const Center(
            child: Text(
              '请求失败，请稍后',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.push) {
      logger.d('(${widget.url}) - player push ');
    } else if (event == LifecycleEvent.visible) {
      logger.d('(${widget.url}) - player visible ');
      _play();
    } else if (event == LifecycleEvent.active) {
      _play();
      logger.d('(${widget.url}) - player active ');
    } else if (event == LifecycleEvent.inactive) {
      logger.d('(${widget.url}) - player inactive ');
    } else if (event == LifecycleEvent.invisible) {
      _pause();
      logger.d('(${widget.url}) - player invisible ');
    } else if (event == LifecycleEvent.pop) {
      _pause();
      logger.d('(${widget.url}) - player pop ');
    }
  }
}
