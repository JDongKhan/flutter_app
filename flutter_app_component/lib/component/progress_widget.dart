import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

class CircleProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: jd_getWidth(150),
      height: jd_getWidth(150),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(jd_getHeight(15)),
        color: Colors.white,
      ),
      child: Container(
        width: jd_getWidth(60),
        height: jd_getWidth(60),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

///显示progress 方式 1
///这种方式，需要在布局中添加FullPageCircleProgressWidget
class FullPageCircleProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: getWidthPx(1334),
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: const Color.fromRGBO(34, 34, 34, 0.3),
      child: CircleProgressWidget(),
    );
  }
}

///显示progress 方式 2
///这种方式，不需要在布局中添加

//typedef LoadingCreate = void Function(DialogLoadingController controller);

class LoadingProgress extends StatefulWidget {
  final Widget progress;
  final Color bgColor;
  //final LoadingCreate loadingCreate;
  final DialogLoadingController controller;

  const LoadingProgress({this.progress, this.bgColor, this.controller});

  @override
  _LoadingProgressState createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.isShow) {
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  void dispose() {
    widget.controller.isShow = false;
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: widget.bgColor ?? const Color.fromRGBO(34, 34, 34, 0.3),
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: widget.progress ?? const CircularProgressIndicator(),
    );
  }
}

class DialogLoadingController extends ChangeNotifier {
  bool isShow = true;
  void dismissDialog() {
    isShow = false;
    notifyListeners();
  }
}

class Common163MusicLoading extends StatefulWidget {
  final String text;

  const Common163MusicLoading({this.text = '加载中...'});

  @override
  _Common163MusicLoadingState createState() => _Common163MusicLoadingState();
}

class _Common163MusicLoadingState extends State<Common163MusicLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CloudMusicLoading(Colors.red, jd_getWidth(20), jd_getWidth(60)),
          SizedBox(width: jd_getWidth(10)),
          Text(
            widget.text,
            style: TextStyle(color: Colors.black, fontSize: jd_getSp(24)),
          )
        ],
      ),
    );
  }
}

class CloudMusicLoading extends StatefulWidget {
  final Color color;
  final double maxWidth, maxHeight;

  const CloudMusicLoading(this.color, this.maxWidth, this.maxHeight);

  @override
  _CloudMusicLoadingState createState() => _CloudMusicLoadingState();
}

class _CloudMusicLoadingState extends State<CloudMusicLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: getWidthPx(80),
      height: jd_getHeight(60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          LoadingItem(widget.color, 0.1, 1.0, jd_getWidth(widget.maxWidth),
              jd_getWidth(widget.maxHeight)),
          LoadingItem(widget.color, 0.4, 1.0, jd_getWidth(widget.maxWidth),
              jd_getWidth(widget.maxHeight)),
          LoadingItem(widget.color, 0.7, 1.0, jd_getWidth(widget.maxWidth),
              jd_getWidth(widget.maxHeight)),
          LoadingItem(widget.color, 0.4, 1.0, jd_getWidth(widget.maxWidth),
              jd_getWidth(widget.maxHeight)),
        ],
      ),
    );
  }

  Widget wrapper(Widget child) {
    return Container();
  }
}

class LoadingItem extends StatefulWidget {
  final Color color;
  final double start, end;
  final double width, height;
  const LoadingItem(this.color, this.start, this.end, this.width, this.height);

  @override
  _LoadingItemState createState() => _LoadingItemState();
}

class _LoadingItemState extends State<LoadingItem>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.value = widget.start;
    super.initState();
    animation.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      width: widget.width,
      height: (animation.value * widget.height).clamp(0.1, widget.height),
    );
  }
}
