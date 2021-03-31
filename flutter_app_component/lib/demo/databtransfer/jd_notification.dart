import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDNotificationPage extends StatefulWidget {

  final String title = "my_notification";

  @override
  _JDNotificationPageState createState() => _JDNotificationPageState();
}

class _JDNotificationPageState extends State<JDNotificationPage> {

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