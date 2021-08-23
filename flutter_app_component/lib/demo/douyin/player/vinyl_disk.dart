import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

/// Rotating vinyl disk with notes go out from its bottom
class VinylDisk extends StatefulWidget {
  String imgUrl;

  VinylDisk(this.imgUrl);

  @override
  _VinylDiskState createState() => _VinylDiskState();
}

class _VinylDiskState extends State<VinylDisk> with TickerProviderStateMixin {
  AnimationController _noteOpacityController;
  Animation<double> _noteOpacityAnimation;
  AnimationController _noteAndDiskController;
  Animation<double> _noteAndDiskAnimation;
  AnimationController _noteRotationController;
  Animation<double> _noteRotationAnimation;
  Tween<double> _noteRotationTween;
  final Random _random = Random();
  Path _path;

  int _pathIndex = 0;
  final int _pathsQuantity = 4;

  final _vinylGradient = LinearGradient(
      colors: [
        Colors.blue[200],
        Colors.blue[300],
        Colors.blue[400],
        Colors.blue[100],
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topLeft,
      stops: [0.2, 0.6, 0.8, 1.0]);

  _drawPath({int quantity, int divider}) {
    final xOffset = jd_getWidth(15);
    final yOffset = jd_getHeight(15.0);
    var size = Size(
      jd_getWidth(110),
      jd_getHeight(90),
    );
    var path = Path();
    for (var i = 0; i <= quantity; i++) {
      var subPath = Path();
      subPath.moveTo(size.width - jd_getWidth(70) / 2,
          size.height - (size.height - jd_getHeight(70)) / 2);
      subPath.cubicTo(
          size.width / 4,
          size.height,
          size.width / 5,
          size.height / 2,
          i <= divider ? i * xOffset : 0,
          i <= divider ? 0 : (i - divider) * yOffset);
      path.addPath(subPath, Offset.zero);
    }
    return path;
  }

  /// Calculates position on a sub path got at [_pathIndex]
  /// [value] should come from [Animation] or [AnimationController]
  /// instance.
  Offset _calculatePosition(double value) {
    var pathMetrics = _path.computeMetrics();
    var pathMetric = pathMetrics.elementAt(_pathIndex);
    value = pathMetric.length * value;
    var pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

  @override
  void initState() {
    super.initState();
    _noteOpacityController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2200),
    );
    _noteOpacityAnimation = CurvedAnimation(
      parent: _noteOpacityController,
      curve: Curves.decelerate,
    );

    _noteRotationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _noteRotationTween = Tween(begin: -.05, end: .05);
    _noteRotationAnimation =
        _noteRotationTween.animate(_noteRotationController);

    _noteAndDiskController = AnimationController(
        duration: Duration(milliseconds: 1000 * 2), vsync: this);
    _noteAndDiskAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_noteAndDiskController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _pathIndex = _random.nextInt(_pathsQuantity);
              _noteRotationTween.begin = -_random.nextInt(_pathsQuantity) / 100;
              _noteRotationTween.end = _random.nextInt(_pathsQuantity) / 100;
              _noteAndDiskController.reset();
              _noteAndDiskController.forward();

              _noteOpacityController.reset();
              _noteOpacityController.reverse(from: 1.0);
            }
          });
    _noteAndDiskController.forward();
    _noteOpacityController.reverse(from: 1.0);
    _noteRotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _noteAndDiskController.dispose();
    _noteRotationController.dispose();
    _noteOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _path = _drawPath(quantity: _pathsQuantity, divider: 1);
    return Container(
      width: jd_getWidth(110),
      height: jd_getHeight(90),
      child: Stack(children: [
        /// Uncomment to see trajectories
        // Positioned(
        //   child: CustomPaint(
        //     painter: PathPainter(path: _path),
        //   ),
        // ),
        AnimatedBuilder(
          animation: _noteAndDiskAnimation,
          builder: (_, child) => Positioned(
            top: _calculatePosition(_noteAndDiskAnimation.value).dy - 70 / 3,
            left: _calculatePosition(_noteAndDiskAnimation.value).dx,
            child: RotationTransition(
              turns: _noteRotationAnimation,
              child: FadeTransition(
                opacity: _noteOpacityAnimation,
                child: Icon(Icons.music_note,
                    color: Colors.grey[200],
                    size: _noteAndDiskAnimation.value * 25),
              ),
            ),
          ),
        ),
        Positioned(
          top: jd_getHeight(90 / 2 - 70 / 2),
          right: 0,
          child: RotationTransition(
            turns: _noteAndDiskAnimation,
            child: Container(
              padding: EdgeInsets.all(12.0),
              width: jd_getWidth(70),
              height: jd_getHeight(70),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _vinylGradient,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage(widget.imgUrl)),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  //网络图片
  _getImage() {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(image: imageProvider),
        ),
      ),
      fit: BoxFit.fitWidth,
      imageUrl: 'assets/images/header_holder.jpg',
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

/// Simple custom painter
class PathPainter extends CustomPainter {
  /// Path to draw on the canvas
  Path path;

  /// Takes path created in [_VinylDiskState]
  PathPainter({this.path});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..color = Colors.red;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
