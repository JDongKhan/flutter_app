import 'package:flutter/material.dart';
import 'package:flutter_component/demo/router/jd_circlepageroute.dart';
import 'package:flutter_component/demo/router/jd_next_route.dart';

class JDRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("提示"),
        ),
      body:  Center(
        child: RaisedButton(
          onPressed: () async {
            // 打开`TipRoute`，并等待返回结果

            Future push = Navigator.of(context).push(JDCirclePageRoutePage<dynamic>(
              builder: (context) {
                return JDNextRoute(text: "我是提示XXXX");
              }
            ));

//            var result = await Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) {
//                  return JDNextRoute(
//                    // 路由参数
//                    text: "我是提示xxxx",
//                  );
//                },
//              ),
//            );
//            //输出`TipRoute`路由返回结果
//            print("路由返回值: $result");
          },
          child: Text("打开提示页"),
        ),
      ),
    );
  }
}