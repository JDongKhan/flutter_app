import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDStreamPage extends StatefulWidget {

  final String title = "jd_stream";

  @override
  _JDStreamPageState createState() => _JDStreamPageState();
}

class _JDStreamPageState extends State<JDStreamPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              children: <Widget>[
              ]
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}