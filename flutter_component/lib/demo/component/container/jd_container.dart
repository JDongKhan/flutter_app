import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDContainerPage extends StatefulWidget {

  final String title = "container";

  @override
  _JDContainerPageState createState() => _JDContainerPageState();
}

class _JDContainerPageState extends State<JDContainerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
                Container(
//                    padding: EdgeInsets.all(50),
//                    color: Colors.yellow,//不能和decoration同时存在
                    margin: EdgeInsets.only(top: 50.0, left: 120.0), //容器外填充
                    constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0), //卡片大小
                    decoration: BoxDecoration(//背景装饰
                        gradient: RadialGradient( //背景径向渐变
                            colors: [Colors.red, Colors.orange],
                            center: Alignment.topLeft,
                            radius: .98
                        ),
                        boxShadow: [ //卡片阴影
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 4.0
                          )
                        ]
                    ),
                    transform: Matrix4.rotationZ(.2), //卡片倾斜变换
                    alignment: Alignment.center, //卡片内文字居中
                    child: Text( //卡片文字
                      "5.20", style: TextStyle(color: Colors.black, fontSize: 40.0),
                    ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(10, 100, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    '哈哈哈哈哈哈哈',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    //背景色
                    color: Colors.green,
                    //圆角
                    borderRadius: BorderRadius.circular(10),
                    //边框
                    border: Border.all(
                      color: Colors.black54,
                      width: 1,
                    ),
                    //阴影
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink,
                        blurRadius: 5.0
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage('https://static.daojia.com/assets/project/tosimple-pic/icon-about-us_1587887989775.png'),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    '哈哈哈哈哈哈哈',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://static.daojia.com/assets/project/tosimple-pic/icon-about-us_1587887989775.png'),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    '哈哈哈哈哈哈哈',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black),
                  ),
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://static.daojia.com/assets/project/tosimple-pic/icon-about-us_1587887989775.png'),
                      alignment: Alignment.centerLeft,
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