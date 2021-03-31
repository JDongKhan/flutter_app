import 'package:flutter/material.dart';

class JDTabHomeFirstPage extends StatefulWidget {
  const JDTabHomeFirstPage(this.title);

  final String title;

  @override
  _JDTabHomeFirstPageState createState() => _JDTabHomeFirstPageState();
}

class _JDTabHomeFirstPageState extends State<JDTabHomeFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(widget.title, textScaleFactor: 5),
    );
  }
}
