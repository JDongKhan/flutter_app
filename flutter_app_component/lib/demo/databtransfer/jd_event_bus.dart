import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDEventBusPage extends StatefulWidget {

  final String title = "jd_event_bus";

  @override
  _JDEventBusPageState createState() => _JDEventBusPageState();
}

class _JDEventBusPageState extends State<JDEventBusPage> {

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