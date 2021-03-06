import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

typedef PlayerValueChanged<T1, T2> = void Function(T1 value1, T2 value2);

class JDPlayerController extends ChangeNotifier {
  bool isPlaying = false;
  void play() {
    isPlaying = true;
    notifyListeners();
  }

  void pause() {
    isPlaying = false;
    notifyListeners();
  }
}

class JDPlayer extends StatefulWidget {
  const JDPlayer({
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
  final JDPlayerController controller;
  @override
  _JDPlayerState createState() => _JDPlayerState();
}

class _JDPlayerState extends State<JDPlayer>
    with WidgetsBindingObserver, LifecycleAware, LifecycleMixin {
  VideoPlayerController _videoPlayerController;
  Future _videoPlayerFuture;
  bool _isPlaying = false;
  bool get isPlaying => _videoPlayerController.value.isPlaying;

  @override
  void initState() {
    super.initState();
    print('initState');
    WidgetsBinding.instance.addObserver(this);
    if (widget.controller != null) {
      widget.controller.addListener(() {
        if (widget.controller.isPlaying) {
          _play();
        } else {
          _pause();
        }
      });
    }
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
  void didUpdateWidget(covariant JDPlayer oldWidget) {
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
                widget.controller.pause();
              } else {
                widget.controller.play();
              }
              if (widget.onTap != null) {
                widget.onTap();
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
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                      color: Colors.white,
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
      print(' -- push -- ');
    } else if (event == LifecycleEvent.visible) {
      print(' -- visible -- ');
    } else if (event == LifecycleEvent.active) {
      widget.controller.play();
      print(' -- active -- ');
    } else if (event == LifecycleEvent.inactive) {
      print(' -- inactive -- ');
    } else if (event == LifecycleEvent.invisible) {
      widget.controller.pause();
      print(' -- invisible -- ');
    } else if (event == LifecycleEvent.pop) {
      print(' -- pop -- ');
    }
  }
}
