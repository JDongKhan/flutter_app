import 'package:flutter/material.dart';

class RowColumnPage extends StatefulWidget {
  final String title = "RowColumn";

  @override
  State createState() => _RowColumnPageState();
}

class _RowColumnPageState extends State<RowColumnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            //测试Row对齐方式，排除Column默认居中对齐的干扰
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" hello world "),
                  Text(" I am Jack "),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(" hello world "),
                  Text(" I am Jack "),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(" hello world "),
                  Text(" I am Jack "),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // textBaseline: TextBaseline.ideographic,
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      height: 200,
                      child: const Text(
                        ' hello world ',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      child: const Text(' I am Jack '),
                    ),
                    Container(
                      color: Colors.blue,
                      child: Text(' I am Jack '),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                        children: <Widget>[
                          Text("hello world "),
                          Text("I am Jack "),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(color: Colors.red, child: Text("第一个")),
                  Container(
                    color: Colors.green,
                    child: Text("第二个"),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Text("第三个"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("第一个"),
                  Text("第二个"),
                  Text("第三个"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("第一个"),
                  Text("第二个"),
                  Text("第三个"),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
                    children: <Widget>[
                      Text("hello world "),
                      Text("I am Jack "),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
