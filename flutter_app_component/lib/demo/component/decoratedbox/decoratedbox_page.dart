import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class DecoratedBoxPage extends StatefulWidget {
  final String title = "decoratedbox";

  @override
  State createState() => _DecoratedBoxPageState();
}

class _DecoratedBoxPageState extends State<DecoratedBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.orange[700]]), //背景渐变
                      borderRadius: BorderRadius.circular(3.0), //3像素圆角
                      boxShadow: [
                        //阴影
                        const BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0)
                      ]),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
