import 'dart:math';

import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class MyNotification extends Notification {
  MyNotification({this.msg});
  final String msg;
}

class JDNotificationPage extends StatefulWidget {
  final String title = "my_notification";

  @override
  _JDNotificationPageState createState() => _JDNotificationPageState();
}

class _JDNotificationPageState extends State<JDNotificationPage> {
  String myMsg = 'first';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          color: Colors.red,
          width: double.infinity,
          child: NotificationListener<MyNotification>(
            onNotification: (notification) {
              setState(() {
                myMsg = notification.msg;
              });
            },
            child: Column(
              children: [
                Text(
                  myMsg,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () {
                        int random = Random().nextInt(10);
                        MyNotification(msg: 'hello-${random}')
                            .dispatch(context);
                      },
                      child: const Text(
                        '点击我，发送一个通知',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
