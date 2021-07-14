import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'cloud_widget.dart';

class CloudDemoPage extends StatefulWidget {
  @override
  _CloudDemoPageState createState() => _CloudDemoPageState();
}

class _CloudDemoPageState extends State<CloudDemoPage> {
  ///Item数据
  final List<CloudItemData> _dataList = const <CloudItemData>[
    CloudItemData('11111111', Colors.amberAccent, 10, false),
    CloudItemData('22222222', Colors.limeAccent, 16, false),
    CloudItemData('33333333', Colors.black, 14, true),
    CloudItemData('44444444', Colors.black87, 33, false),
    CloudItemData('55555555', Colors.blueAccent, 15, false),
    CloudItemData('66666666', Colors.indigoAccent, 16, false),
    CloudItemData('77777777', Colors.deepOrange, 12, true),
    CloudItemData('88888888', Colors.blue, 20, true),
    CloudItemData('99999999', Colors.blue, 12, false),
    CloudItemData('00000000', Colors.deepPurpleAccent, 14, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CloudDemoPage"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,

          ///利用 FittedBox 约束 child
          child: FittedBox(
            /// Cloud 布局
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              color: Colors.red,

              ///布局
              child: CloudWidget(
                ///容器宽高比例
                ratio: 1,
                children: <Widget>[
                  ..._dataList
                      .map(
                        (item) =>

                            ///判断是否旋转
                            RotatedBox(
                          quarterTurns: item.rotate ? 1 : 0,
                          child: Text(
                            item.text,
                            style: TextStyle(
                              fontSize: item.size,
                              color: item.color,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CloudItemData {
  ///文本
  final String text;

  ///颜色
  final Color color;

  ///旋转
  final bool rotate;

  ///大小
  final double size;

  const CloudItemData(
    this.text,
    this.color,
    this.size,
    this.rotate,
  );
}
