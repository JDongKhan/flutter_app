import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// @author jd

class Progress {
  const Progress({
    this.value,
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.radius = 150,
    this.strokeWidth = 2,
    this.completeText = '完成',
    this.style,
    this.dotCount = 40,
  });
  final double value;
  final Color color;
  final Color backgroundColor;
  final double radius;
  final double strokeWidth;
  final int dotCount;
  final TextStyle style;
  final String completeText;
}

class CircleProgressWidget extends StatefulWidget {
  const CircleProgressWidget({Key key, this.progress}) : super(key: key);
  final Progress progress;

  @override
  _CircleProgressWidgetState createState() => _CircleProgressWidgetState();
}

class _CircleProgressWidgetState extends State<CircleProgressWidget> {
  @override
  Widget build(BuildContext context) {
    var progress = Container(
      width: widget.progress.radius * 2,
      height: widget.progress.radius * 2,
      child: CustomPaint(
        painter: ProgressPainter(progress: widget.progress),
      ),
    );
    String txt = '${(100 * widget.progress.value).toStringAsFixed(1)} %';
    var text = Text(
      widget.progress.value == 1.0 ? widget.progress.completeText : txt,
      style: widget.progress.style ??
          TextStyle(fontSize: widget.progress.radius / 6),
    );
    return Stack(
      alignment: Alignment.center,
      children: [progress, text],
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({this.progress}) {
    _arrowPath = Path();
    _arrowPaint = Paint();
    _paint = Paint();
    _radius = progress.radius - progress.strokeWidth / 2;
  }
  final Progress progress;
  Paint _paint;
  Paint _arrowPaint; //箭头的画笔
  Path _arrowPath; //箭头的路径
  double _radius; //半径

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.translate(progress.strokeWidth / 2, progress.strokeWidth / 2);
    // Rect rect = Offset.zero & size;
    // canvas.clipRect(rect);
    //画进度a
    _drawProgress(canvas);
    //画箭头
    _drawArrow(canvas);
    //画点
    _drawDot(canvas);
  }

  //画进度
  void _drawProgress(Canvas canvas) {
    canvas.save();
    //背景
    _paint
      ..style = PaintingStyle.stroke
      ..color = progress.backgroundColor
      ..strokeWidth = progress.strokeWidth;
    canvas.drawCircle(Offset(_radius, _radius), _radius, _paint);

    //进度
    _paint
      ..color = progress.color
      ..strokeWidth = (progress.strokeWidth * 1.2)
      ..strokeCap = StrokeCap.round;

    double sweepAngle = progress.value * 360; //完成角度
    canvas.drawArc(Rect.fromLTRB(0, 0, _radius * 2, _radius * 2),
        -90 / 180 * pi, sweepAngle / 180 * pi, false, _paint);
    canvas.restore();
  }

  //画箭头
  void _drawArrow(Canvas canvas) {
    canvas.save();
    canvas.translate(_radius, _radius);
    canvas.rotate((0 + progress.value * 360) / 180 * pi);
    var half = _radius / 2;
    var eg = _radius / 50; //单位长
    _arrowPath.moveTo(0, -half - eg * 2); //
    _arrowPath.relativeLineTo(eg * 2, eg * 6);
    _arrowPath.lineTo(0, -half + eg * 2);
    _arrowPath.lineTo(0, -half - eg * 2);
    _arrowPath.relativeLineTo(-eg * 2, eg * 6);
    _arrowPath.lineTo(0, -half + eg * 2);
    _arrowPath.lineTo(0, -half - eg * 2);
    canvas.drawPath(_arrowPath, _arrowPaint);
    canvas.restore();
  }

  //画点
  void _drawDot(Canvas canvas) {
    canvas.save();
    int num = progress.dotCount;
    canvas.translate(_radius, _radius);
    for (double i = 0; i < num; i++) {
      canvas.save();
      double deg = 360 / num * i;
      //旋转角度
      canvas.rotate(pi + deg / 180 * pi);
      _paint
        ..strokeWidth = progress.strokeWidth / 2
        ..color = progress.backgroundColor
        ..strokeCap = StrokeCap.round;
      if (i * (360 / num) <= progress.value * 360) {
        _paint.color = progress.color;
      }
      canvas.drawLine(
          Offset(0, _radius * 3 / 4), Offset(0, _radius * 4 / 5), _paint);
      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
