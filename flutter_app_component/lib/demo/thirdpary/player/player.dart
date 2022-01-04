import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:video_player/video_player.dart';

/// @author jd

typedef PlayerValueChanged<T1, T2> = void Function(T1 value1, T2 value2);

class Player extends StatefulWidget {
  const Player({
    Key key,
    this.onTap,
    this.onChange,
    this.playStatus,
    this.autoPlay = false,
    @required this.loadFuture,
    @required this.controller,
    this.debugLabel = 'player',
  })  : assert(controller != null),
        super(key: key);

  final ValueChanged<bool> playStatus;
  final Future loadFuture;
  final Function onTap;
  final PlayerValueChanged<Duration, Duration> onChange;
  final VideoPlayerController controller;
  final String debugLabel;
  final bool autoPlay;
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player>
    with WidgetsBindingObserver, LifecycleAware, LifecycleMixin {
  //主动操作
  bool _manualPlaying = false;
  //被动状态
  bool _passivePlaying;
  bool get isPlaying {
    if (_videoPlayerController == null) {
      return false;
    }
    if (_videoPlayerController.value == null) {
      return false;
    }
    return _videoPlayerController?.value?.isPlaying;
  }

  bool _visiable = false;
  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = widget.controller;
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-initState');
    WidgetsBinding.instance.addObserver(this);
    //准备
    if (widget.controller != null && widget.autoPlay) {
      _play();
    }
  }

  @override
  void dispose() {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-dispose');
    _videoPlayerController = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void reassemble() {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-reassemble');
    super.reassemble();
  }

  @override
  void didChangeDependencies() {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Player oldWidget) {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-deactivate');
    super.deactivate();
  }

  @override
  void didChangeMetrics() {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-didChangeMetrics');
  }

  @override
  Future<bool> didPushRoute(String route) {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-didPushRoute');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-didPopRoute');
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-didChangeAppLifecycleState');
  }

  void _listener() {
    if (!mounted) {
      return;
    }
    if (!_visiable) {
      return;
    }
    if (widget.onChange != null) {
      widget.onChange(_videoPlayerController.value.position,
          _videoPlayerController.value.duration);
    }
    final bool isPlaying = _videoPlayerController.value.isPlaying;
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-listener-${_videoPlayerController.value.position}-${_videoPlayerController.value.duration}');
    if (_passivePlaying != null && isPlaying != _passivePlaying) {
      setState(() {
        if (widget.playStatus != null) {
          widget.playStatus(isPlaying);
        }
      });
    }
    _passivePlaying = isPlaying;
  }

  void _play() {
    if (_manualPlaying || !mounted) return;
    if (!_visiable) return;
    if (_videoPlayerController.value.isPlaying) return;
    _videoPlayerController.play();
    _manualPlaying = true;
    _videoPlayerController.addListener(_listener);
    setState(() {});
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-play() ');
  }

  void _pause() {
    if (!_manualPlaying || !mounted) return;
    _videoPlayerController.pause();
    _manualPlaying = false;
    setState(() {});
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-pause() ');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-build');
    if (widget.controller.value.isPlaying) {
      return _playingWidget();
    }
    return FutureBuilder(
      future: widget.loadFuture ?? widget.controller.initialize(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _playingWidget();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _play();
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

  Widget _playingWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      onDoubleTap: () {
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
                  final bool isPlaying = widget.controller.value.isPlaying;
                  if (isPlaying) {
                    _pause();
                  } else {
                    _play();
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
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.push) {
      _visiable = true;
      debugPrint(
          'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-onLifecycleEvent push ');
    } else if (event == LifecycleEvent.visible) {
      _visiable = true;
      debugPrint(
          'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-onLifecycleEvent visible ');
    } else if (event == LifecycleEvent.active) {
      _visiable = true;
      widget.controller.play();
      debugPrint(
          'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-onLifecycleEvent active ');
    } else if (event == LifecycleEvent.inactive) {
      _visiable = false;
      widget.controller.pause();
      debugPrint(
          'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-onLifecycleEvent inactive ');
    } else if (event == LifecycleEvent.invisible) {
      _visiable = false;
      debugPrint(
          'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-onLifecycleEvent invisible ');
    } else if (event == LifecycleEvent.pop) {
      _visiable = false;
      debugPrint(
          'player[${widget.debugLabel}]-[${widget.controller.dataSource}]-onLifecycleEvent pop ');
    }
  }
}
