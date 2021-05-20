import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class BorderTimeLine extends BorderDirectional {
  int position;

  BorderTimeLine(this.position);

  double radius = 10;
  double margin = 20;
  Paint _paint = Paint()
    ..color = Color(0xFFDDDDDD)
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius borderRadius}) {
    if (position != 0) {
      canvas.drawLine(Offset(rect.left + margin + radius / 2, rect.top),
          Offset(rect.left + margin + radius / 2, rect.bottom), _strokePaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _fillPaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _strokePaint());
    } else {
      canvas.drawLine(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          Offset(rect.left + margin + radius / 2, rect.bottom),
          _strokePaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _fillPaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius,
          _strokePaint());
      canvas.drawCircle(
          Offset(rect.left + margin + radius / 2, rect.top + radius * 2),
          radius / 2,
          _strokePaint());
    }
  }

  Paint _fillPaint() {
    _paint.color = Colors.white;
    _paint.style = PaintingStyle.fill;
    return _paint;
  }

  Paint _strokePaint() {
    _paint.color = Color(0xFFDDDDDD);
    _paint.style = PaintingStyle.stroke;
    return _paint;
  }
}

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeLine'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(border: BorderTimeLine(index)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 40,
            ),
            Text(
              '我是标题：$index',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              '我是内容：abc\n',
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
