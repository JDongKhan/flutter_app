import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/utils/logger_util.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

class DouyinPlayerController extends ChangeNotifier {
  DouyinPlayerController({
    this.url,
    this.isPlaying = false,
    this.loop = true,
  }) : videoPlayerController = VideoPlayerController.asset(url);

  String url;
  bool isPlaying;
  bool loop;

  VideoPlayerController videoPlayerController;
  Future _videoPlayerFuture;

  ///准备
  void prepare() {
    _videoPlayerFuture = videoPlayerController.initialize().then((value) {
      if (isPlaying) {
        play();
      }
    });
    videoPlayerController.setLooping(loop);
    videoPlayerController.addListener(_listener);
  }

  ///播放
  void play() {
    isPlaying = true;
    videoPlayerController.play();
    notifyListeners();
  }

  ///暂停
  void pause() {
    isPlaying = false;
    videoPlayerController.pause();
    notifyListeners();
  }

  void _listener() {
    final bool isPlaying = videoPlayerController.value.isPlaying;
    if (isPlaying != isPlaying) {
      this.isPlaying = isPlaying;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    debugPrint('player-dispose');
    videoPlayerController.dispose();
    super.dispose();
  }
}

class DouyinPlayer extends StatefulWidget {
  const DouyinPlayer({
    this.source,
    @required this.douyinPlayerController,
  });
  final String source;
  final DouyinPlayerController douyinPlayerController;
  @override
  _DouyinPlayerState createState() => _DouyinPlayerState();
}

class _DouyinPlayerState extends State<DouyinPlayer>
    with WidgetsBindingObserver, LifecycleAware, LifecycleMixin {
  @override
  void initState() {
    super.initState();
    logger.d('(${widget.douyinPlayerController.url}) - player initState');
    WidgetsBinding.instance.addObserver(this);
    if (widget.douyinPlayerController != null) {
      widget.douyinPlayerController.addListener(_listener);
      widget.douyinPlayerController.prepare();
    }
  }

  ///监听
  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    logger.d('(${widget.douyinPlayerController.url}) - player dispose');
    widget.douyinPlayerController.removeListener(_listener);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    logger.d(
        '(${widget.douyinPlayerController.url}) - player didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DouyinPlayer oldWidget) {
    logger.d('(${widget.douyinPlayerController.url}) - player didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    logger.d('(${widget.douyinPlayerController.url}) - player deactivate');
    super.deactivate();
  }

  @override
  void didChangeMetrics() {
    logger
        .d('(${widget.douyinPlayerController.url}) - player didChangeMetrics');
  }

  @override
  Future<bool> didPushRoute(String route) {
    logger.d('(${widget.douyinPlayerController.url}) - player didPushRoute');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    logger.d('(${widget.douyinPlayerController.url}) - player didPopRoute');
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.d(
        '(${widget.douyinPlayerController.url}) - player didChangeAppLifecycleState');
  }

  @override
  Widget build(BuildContext context) {
    logger.d('(${widget.douyinPlayerController.url}) - build');
    return FutureBuilder(
      future: widget.douyinPlayerController._videoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final bool isPlaying = widget
                  .douyinPlayerController.videoPlayerController.value.isPlaying;
              if (isPlaying) {
                widget.douyinPlayerController.pause();
              } else {
                widget.douyinPlayerController.play();
              }
            },
            child: Stack(
              children: [
                VideoPlayer(
                  widget.douyinPlayerController.videoPlayerController,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: widget.douyinPlayerController.isPlaying ? 0 : 1.0,
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
            widget.douyinPlayerController.prepare();
          },
          child: const Center(
            child: Text(
              '加载中，请稍后',
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
      logger.d('(${widget.douyinPlayerController.url}) - player push ');
    } else if (event == LifecycleEvent.visible) {
      logger.d('(${widget.douyinPlayerController.url}) - player visible ');
      widget.douyinPlayerController.play();
    } else if (event == LifecycleEvent.invisible) {
      widget.douyinPlayerController.pause();
      logger.d('(${widget.douyinPlayerController.url}) - player invisible ');
    } else if (event == LifecycleEvent.active) {
      logger.d('(${widget.douyinPlayerController.url}) - player active ');
    } else if (event == LifecycleEvent.inactive) {
      logger.d('(${widget.douyinPlayerController.url}) - player inactive ');
    } else if (event == LifecycleEvent.pop) {
      widget.douyinPlayerController.pause();
      logger.d('(${widget.douyinPlayerController.url}) - player pop ');
    }
  }
}
