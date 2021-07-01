import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class CircleHalo extends StatefulWidget {
  @override
  _CircleHaloState createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circle halo'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(200, 200),
          painter: CircleHaloPainter(_animationController),
        ),
      ),
    );
  }
}

class CircleHaloPainter extends CustomPainter {
  Animation<double> animation;

  CircleHaloPainter(this.animation) : super(repaint: animation);

  final Animatable<double> rotateTween =
      Tween<double>(begin: 0, end: 2 * pi).chain(
    CurveTween(
      curve: Curves.easeIn,
    ),
  );

  final Animatable<double> breathTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 4), weight: 1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 4, end: 1), weight: 1),
    ],
  ).chain(
    CurveTween(
      curve: Curves.decelerate,
    ),
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path circlePath = Path()
      ..addOval(Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));
    Path circlePath2 = Path()
      ..addOval(
          Rect.fromCenter(center: Offset(-1, 0), width: 100, height: 100));

    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);
    List<Color> colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    colors.addAll(colors.reversed.toList());
    final List<double> pos =
        List.generate(colors.length, (index) => index / colors.length);
    paint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, 0, 2 * pi);
    paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breathTween.evaluate(animation));
    canvas.drawPath(circlePath, paint);
    canvas.save();
    canvas.rotate(animation.value * 2 * pi);
    paint
      ..style = PaintingStyle.fill
      ..color = Color(0xff00abf2);
    paint.shader = null;
    canvas.drawPath(result, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}