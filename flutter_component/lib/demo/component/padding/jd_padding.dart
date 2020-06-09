import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDPaddingPage extends StatefulWidget {

  final String title = "padding";

  @override
  State createState() => _JDPaddingPageState();
}

class _JDPaddingPageState extends State<JDPaddingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
            children: <Widget>[
              Padding(
                //上下左右各添加16像素补白
                padding: EdgeInsets.all(16.0),
                child: Column(
                  //显式指定对齐方式为左对齐，排除对齐干扰
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      //左边添加8像素补白
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Hello world"),
                    ),
                    Padding(
                      //上下各添加8像素补白
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("I am Jack"),
                    ),
                    Padding(
                      // 分别指定四个方向的补白
                      padding: const EdgeInsets.fromLTRB(20.0,.0,20.0,20.0),
                      child: Text("Your friend"),
                    )
                  ],
                ),
              ),

            ],
          )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}