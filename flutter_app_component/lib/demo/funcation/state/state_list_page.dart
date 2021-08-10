import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/funcation//state/tapbox_a_page.dart';
import 'package:flutter_app_component/demo/funcation//state/tapbox_b_page.dart';
import 'package:flutter_app_component/demo/funcation//state/tapbox_c_page.dart';

class StateListPage extends StatefulWidget {
  String title;

  StateListPage({Key key, this.title}) : super(key: key);

  @override
  State createState() => _StateListPageState();
}

class _StateListPageState extends State<StateListPage> {
  final _list = <Map<String, Widget>>[
    {"TapboxA": TapboxAPage()},
    {"TapboxB": ParentWidgetBPage()},
    {"TapboxC": ParentWidgetCPage()}
  ];

  Widget _buildList() {
    return new ListView.builder(
        itemCount: _list.length * 2,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;

          Map<String, Widget> map = _list[index];
          String text = map.keys.first;
          return new ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: new Text(
              text,
              style: TextStyle(fontSize: 18.0),
            ),
            leading: new Image.asset("assets/images/head.png"),
            onTap: () {
              _pushSaved(text, map.values.first);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    widget.title = "State List";
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body:
            _buildList() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _pushSaved(String title, Widget widget) async {
    //此种方法可传参
    Future map = Navigator.of(context).push(
      CupertinoPageRoute<dynamic>(
        builder: (context) {
          return widget;
        },
      ),
    );
    debugPrint(map.toString());
  }
}
