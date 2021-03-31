import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class JDExpandableText extends StatefulWidget {
  const JDExpandableText(
    this.text, {
    Key key,
    this.maxLines = 4,
    this.style = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.expand = false,
    this.markerStyle = const TextStyle(
      fontSize: 15,
      color: Colors.orange,
    ),
    this.atName,
  }) : super(key: key);

  final String text;
  final int maxLines;
  final TextStyle style;
  final bool expand;
  final TextStyle markerStyle;
  final String atName;

  @override
  _JDExpandableTextState createState() => _JDExpandableTextState();
}

class _JDExpandableTextState extends State<JDExpandableText> {
  bool expand;
  TextStyle style;
  int maxLines;

  @override
  void initState() {
    expand = widget.expand;
    style = widget.style;
    maxLines = widget.maxLines;
    super.initState();
  }

  Widget buildOrdinaryText() {
    final String text = widget.text;
    return LayoutBuilder(builder: (_, size) {
      final TextPainter tp = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.maxWidth);

      if (!tp.didExceedMaxLines) {
        return Text(text, style: style);
      }

      return Builder(
        builder: (BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text, maxLines: expand ? null : widget.maxLines, style: style),
            GestureDetector(
              onTap: () {
                expand = !expand;
                (context as Element).markNeedsBuild();
              },
              child: Text(
                expand ? '收起' : '展开',
                style: widget.markerStyle,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildAtText() {
    return LayoutBuilder(builder: (_, size) {
      final TextPainter tp = TextPainter(
        text: TextSpan(text: '回复 @${widget.text}：', style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.maxWidth);

      if (!tp.didExceedMaxLines)
        return Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: '回复 '),
              TextSpan(text: '@${widget.atName}', style: widget.markerStyle),
              TextSpan(text: '：${widget.text}'),
            ],
          ),
          style: style,
        );

      return Builder(
        builder: (BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '回复 '),
                  TextSpan(
                      text: '@${widget.atName}', style: widget.markerStyle),
                  TextSpan(text: '：${widget.text}'),
                ],
              ),
              maxLines: expand ? null : widget.maxLines,
              style: style,
            ),
            GestureDetector(
              onTap: () {
                expand = !expand;
                (context as Element).markNeedsBuild();
              },
              child: Text(
                expand ? '收起' : '展开',
                style: widget.markerStyle,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.atName == '' ? buildOrdinaryText() : buildAtText();
  }
}
