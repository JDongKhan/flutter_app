import 'package:flutter/material.dart';

/// @author jd

class JDNotFindPage extends StatefulWidget {
  final String title = '迷路了';

  @override
  _JDNotFindPageState createState() => _JDNotFindPageState();
}

class _JDNotFindPageState extends State<JDNotFindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(children: const <Widget>[
            Text('我迷路了哎'),
          ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
