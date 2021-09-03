import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

typedef PlayerValueChanged<T1, T2> = void Function(T1 value1, T2 value2);

class PlayerController extends ChangeNotifier {
  PlayerController({
    bool initPlaying = false,
    @required this.url,
    this.loop = true,
  }) : isPlaying = initPlaying;

  bool isPlaying = false;
  Duration seekDuration;
  String url;
  final bool loop;

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

  @override
  void dispose() {
    super.dispose();
  }
}

class Player extends StatefulWidget {
  const Player({
    Key key,
    this.onTap,
    this.onChange,
    this.playStatus,
    @required this.controller,
  })  : assert(controller != null),
        super(key: key);

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
    debugPrint('player[${widget.controller.url}]-initState');
    WidgetsBinding.instance.addObserver(this);
    if (widget.controller != null) {
      widget.controller.addListener(_outListener);
    }
    //准备
    _prepare(() {
      if (widget.controller != null && widget.controller.isPlaying) {
        _play();
      }
    });
  }

  void _outListener() {
    if (!mounted) {
      return;
    }
    if (widget.controller.isPlaying) {
      _play();
    } else {
      _pause();
    }

    if (widget.controller.seekDuration != null) {
      _videoPlayerController.seekTo(widget.controller.seekDuration);
    }
  }

  @override
  void dispose() {
    debugPrint('player[${widget.controller.url}]-dispose');
    _videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void reassemble() {
    debugPrint('player[${widget.controller.url}]-reassemble');
    super.reassemble();
  }

  @override
  void didChangeDependencies() {
    debugPrint('player[${widget.controller.url}]-didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Player oldWidget) {
    debugPrint('player[${widget.controller.url}]-didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    debugPrint('player[${widget.controller.url}]-deactivate');
    super.deactivate();
  }

  @override
  void didChangeMetrics() {
    debugPrint('player[${widget.controller.url}]-didChangeMetrics');
  }

  @override
  Future<bool> didPushRoute(String route) {
    debugPrint('player[${widget.controller.url}]-didPushRoute');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    debugPrint('player[${widget.controller.url}]-didPopRoute');
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('player[${widget.controller.url}]-didChangeAppLifecycleState');
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

  void _prepare(Function callback) {
    _videoPlayerController = VideoPlayerController.asset(widget.controller.url);
    _videoPlayerFuture = _videoPlayerController.initialize().then((value) {
      callback();
    });
    _videoPlayerController.setLooping(widget.controller.loop);
    _videoPlayerController.addListener(_listener);
  }

  void _play() {
    if (isPlaying || !mounted) return;
    _videoPlayerController.play();
    debugPrint('player[${widget.controller.url}]-play() ');
  }

  void _pause() {
    if (!isPlaying || !mounted) return;
    _videoPlayerController.pause();
    debugPrint('player[${widget.controller.url}]-pause() ');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('player[${widget.controller.url}]-build');
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
      debugPrint('player[${widget.controller.url}]-onLifecycleEvent push ');
    } else if (event == LifecycleEvent.visible) {
      debugPrint('player[${widget.controller.url}]-onLifecycleEvent visible ');
    } else if (event == LifecycleEvent.active) {
      widget.controller.play();
      debugPrint('player[${widget.controller.url}]-onLifecycleEvent active ');
    } else if (event == LifecycleEvent.inactive) {
      widget.controller.pause();
      debugPrint('player[${widget.controller.url}]-onLifecycleEvent inactive ');
    } else if (event == LifecycleEvent.invisible) {
      debugPrint(
          'player[${widget.controller.url}]-onLifecycleEvent invisible ');
    } else if (event == LifecycleEvent.pop) {
      debugPrint('player[${widget.controller.url}]-onLifecycleEvent pop ');
    }
  }
}
