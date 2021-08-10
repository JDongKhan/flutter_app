import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

typedef PlayerValueChanged<T1, T2> = void Function(T1 value1, T2 value2);

class PlayerController extends ChangeNotifier {
  bool isPlaying = false;
  Duration seekDuration;
  void play() {
    isPlaying = true;
    notifyListeners();
  }

  void pause() {
    isPlaying = false;
    notifyListeners();
  }

  void seek(Duration duration) {
    seekDuration = duration;
    notifyListeners();
  }
}

class Player extends StatefulWidget {
  const Player({
    Key key,
    @required this.url,
    this.loop = true,
    this.onTap,
    this.onChange,
    this.playStatus,
    @required this.controller,
  }) : super(key: key);

  final String url;
  final bool loop;
  final ValueChanged<bool> playStatus;
  final Function onTap;
  final PlayerValueChanged<Duration, Duration> onChange;
  final PlayerController controller;
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player>
    with WidgetsBindingObserver, LifecycleAware, LifecycleMixin {
  VideoPlayerController _videoPlayerController;
  Future _videoPlayerFuture;
  bool _isPlaying = false;
  bool get isPlaying => _videoPlayerController.value.isPlaying;

  @override
  void initState() {
    super.initState();
    debugPrint('initState');
    WidgetsBinding.instance.addObserver(this);
    if (widget.controller != null) {
      widget.controller.addListener(() {
        if (widget.controller.isPlaying) {
          _play();
        } else {
          _pause();
        }

        if (widget.controller.seekDuration != null) {
          _videoPlayerController.seekTo(widget.controller.seekDuration);
        }
      });
    }
    //准备
    _prepare();
  }

  @override
  void dispose() {
    debugPrint('dispose');
    _videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void reassemble() {
    debugPrint('reassemble');
    super.reassemble();
  }

  @override
  void didChangeDependencies() {
    debugPrint('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Player oldWidget) {
    debugPrint('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    debugPrint('deactivate');
    super.deactivate();
  }

  @override
  void didChangeMetrics() {
    debugPrint('didChangeMetrics');
  }

  @override
  Future<bool> didPushRoute(String route) {
    debugPrint('didPushRoute');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    debugPrint('didPopRoute');
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('didChangeAppLifecycleState');
  }

  void _listener() {
    if (!mounted) {
      return;
    }
    if (widget.onChange != null) {
      widget.onChange(_videoPlayerController.value.position,
          _videoPlayerController.value.duration);
    }
    final bool isPlaying = _videoPlayerController.value.isPlaying;
    if (isPlaying != _isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
        if (widget.playStatus != null) {
          widget.playStatus(isPlaying);
        }
        ;
      });
    }
  }

  void _prepare() {
    _videoPlayerController = VideoPlayerController.asset(widget.url);
    _videoPlayerFuture = _videoPlayerController.initialize().then((value) {
      widget.controller.play();
    });
    _videoPlayerController.setLooping(widget.loop);
    _videoPlayerController.addListener(_listener);
  }

  void _play() {
    if (isPlaying) return;
    _videoPlayerController.play();
  }

  void _pause() {
    if (!isPlaying) return;
    _videoPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return FutureBuilder(
      future: _videoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap();
              }
            },
            onDoubleTap: () {
              final bool isPlaying = _videoPlayerController.value.isPlaying;
              if (isPlaying) {
                widget.controller.pause();
              } else {
                widget.controller.play();
              }
            },
            child: Stack(
              children: [
                Container(
                  color: Colors.black,
                ),
                VideoPlayer(_videoPlayerController),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isPlaying ? 0 : 1.0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        final bool isPlaying =
                            _videoPlayerController.value.isPlaying;
                        if (isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: const Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
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
      debugPrint(' -- onLifecycleEvent push -- ');
    } else if (event == LifecycleEvent.visible) {
      debugPrint(' -- onLifecycleEvent visible -- ');
    } else if (event == LifecycleEvent.active) {
      widget.controller.play();
      debugPrint(' -- onLifecycleEvent active -- ');
    } else if (event == LifecycleEvent.inactive) {
      debugPrint(' -- onLifecycleEvent inactive -- ');
    } else if (event == LifecycleEvent.invisible) {
      widget.controller.pause();
      debugPrint(' -- onLifecycleEvent invisible -- ');
    } else if (event == LifecycleEvent.pop) {
      debugPrint(' -- onLifecycleEvent pop -- ');
    }
  }
}
