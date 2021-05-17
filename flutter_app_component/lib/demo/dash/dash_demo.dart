import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/component/dash_decoration.dart';
import 'package:flutter_app_component/component/dash_painter.dart';

/// @author jd
// 来源:https://juejin.cn/post/6960468833073102885
class DashDemo extends StatefulWidget {
  @override
  _DashDemoState createState() => _DashDemoState();
}

class _DashDemoState extends State<DashDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dash Demo'),
      ),
      body: Column(
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: Painter(),
          ),
          const SizedBox(
            height: 120,
          ),
          Container(
            width: 100,
            height: 100,
            decoration: DashDecoration(
                pointWidth: 2,
                step: 5,
                pointCount: 1,
                radius: const Radius.circular(15),
                gradient: const SweepGradient(colors: [
                  Colors.blue,
                  Colors.red,
                  Colors.yellow,
                  Colors.green
                ])),
            child: const Icon(
              Icons.add,
              color: Colors.orangeAccent,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.orangeAccent
      ..strokeWidth = 1;

    final Path path = Path();
    path.moveTo(-200, 0);
    path.lineTo(200, 0);
    path.moveTo(0, -200);
    path.lineTo(0, 200);

    path.addOval(Rect.fromCircle(center: Offset.zero, radius: 80));
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCircle(center: Offset.zero, radius: 100),
      const Radius.circular(20),
    ));
    const DashPainter(span: 4, step: 9).paint(canvas, path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
