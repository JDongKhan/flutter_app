import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

class DouyinPlayer extends StatefulWidget {
  DouyinPlayer({this.url, this.loop = true});
  final String url;
  final bool loop;
  @override
  _DouyinPlayerState createState() => _DouyinPlayerState();
}

class _DouyinPlayerState extends State<DouyinPlayer>
    with WidgetsBindingObserver, LifecycleAware, LifecycleMixin {
  VideoPlayerController _videoPlayerController;
  bool _isPlaying;
  Future _videoPlayerFuture;
  @override
  void initState() {
    super.initState();
    print('initState');
    WidgetsBinding.instance.addObserver(this);
    //准备
    _prepare();
  }

  @override
  void dispose() {
    print('dispose');
    _videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DouyinPlayer oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void didChangeMetrics() {
    print('didChangeMetrics');
  }

  @override
  Future<bool> didPushRoute(String route) {
    print('didPushRoute');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    print('didPopRoute');
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('didChangeAppLifecycleState');
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

  void _prepare() {
    _videoPlayerController = VideoPlayerController.asset(widget.url);
    _videoPlayerFuture = _videoPlayerController.initialize().then((value) {
      _play();
    });
    _videoPlayerController.setLooping(widget.loop);
    _videoPlayerController.addListener(_listener);
  }

  void _play() {
    _videoPlayerController.play();
    setState(() {
      _isPlaying = true;
    });
  }

  void _stop() {
    _videoPlayerController.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return FutureBuilder(
      future: _videoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final bool isPlaying = _videoPlayerController.value.isPlaying;
              if (isPlaying) {
                _stop();
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
                      Icons.play_arrow,
                      size: 80,
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
            _prepare();
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
      print(' -- push -- ');
    } else if (event == LifecycleEvent.visible) {
      print(' -- visible -- ');
    } else if (event == LifecycleEvent.active) {
      _play();
      print(' -- active -- ');
    } else if (event == LifecycleEvent.inactive) {
      print(' -- inactive -- ');
    } else if (event == LifecycleEvent.invisible) {
      _stop();
      print(' -- invisible -- ');
    } else if (event == LifecycleEvent.pop) {
      print(' -- pop -- ');
    }
  }
}
