import 'package:flutter/material.dart';
import 'dart:math' as math;

/**
 *
 * @author jd
 *
 */

class JDTransformPage extends StatefulWidget {

  final String title = "transform";

  @override
  State createState() => _JDTransformPageState();
}

class _JDTransformPageState extends State<JDTransformPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: 50,),

              Container(
                 color: Colors.black,
                   child: new Transform(
                     alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                     transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                     child: new Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.deepOrange,
                        child: const Text('Apartment for rent!'),
                    ),
                  ),
              ),

              SizedBox(height: 50,),

              DecoratedBox(
                decoration:BoxDecoration(color: Colors.red),
                //默认原点为左上角，左移20像素，向上平移5像素
                child: Transform.translate(
                  offset: Offset(-20.0, -5.0),
                  child: Text("Hello world"),
                ),
              ),

              SizedBox(height: 50,),

              DecoratedBox(
                decoration:BoxDecoration(color: Colors.red),
                child: Transform.rotate(
                  //旋转90度
                  angle:math.pi/2 ,
                  child: Text("Hello world"),
                ),
              ),

              SizedBox(height: 50,),

              DecoratedBox(
                  decoration:BoxDecoration(color: Colors.red),
                  child: Transform.scale(
                      scale: 1.5, //放大到1.5倍
                      child: Text("Hello world")
                  )
              ),

              SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                      decoration:BoxDecoration(color: Colors.red),
                      child: Transform.scale(scale: 1.5,
                          child: Text("Hello world")
                      )
                  ),
                  Text("你好", style: TextStyle(color: Colors.green, fontSize: 18.0),)
                ],
              ),

              SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    //将Transform.rotate换成RotatedBox
                    child: RotatedBox(
                      quarterTurns: 1, //旋转90度(1/4圈)
                      child: Text("Hello world"),
                    ),
                  ),
                  Text("你好", style: TextStyle(color: Colors.green, fontSize: 18.0),)
                ],
              ),

            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}