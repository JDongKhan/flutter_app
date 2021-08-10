import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class SingleChildScrollViewPage extends StatefulWidget {
  final String title = "singlechildscrollView";

  @override
  State createState() => _SingleChildScrollViewPagePageState();
}

class _SingleChildScrollViewPagePageState
    extends State<SingleChildScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Scrollbar(
                // 显示进度条
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      //动态创建一个List<Widget>
                      children: str
                          .split("")
                          //每一个字母都用一个Text显示,字体为原来的两倍
                          .map((c) => Text(
                                c,
                                textScaleFactor: 2.0,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
