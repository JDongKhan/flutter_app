import 'package:flutter/material.dart';

import 'stick_widget.dart';

class StickDemoPage extends StatefulWidget {
  @override
  _StickDemoPageState createState() => _StickDemoPageState();
}

class _StickDemoPageState extends State<StickDemoPage> {
  @override
  Widget build(_) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StickDemoPage"),
      ),
      body: Container(
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 100,
            itemBuilder: (context, index) {
              return Container(
                height: 200,
                color: Colors.deepOrange,
                child: StickWidget(
                  ///header
                  stickHeader: Container(
                    height: 50.0,
                    color: Colors.deepPurple,
                    padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        print("header");
                      },
                      child: Text(
                        '我的 $index 头啊',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  ///content
                  stickContent: InkWell(
                    onTap: () {
                      print("content");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      color: Colors.pinkAccent,
                      height: 150,
                      child: Center(
                        child: Text(
                          '我的$index 内容 啊',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
