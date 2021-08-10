import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/bookpage/book_page.dart';
import 'package:flutter_app_component/demo/fishredux/OnePage/page.dart';
import 'package:flutter_app_component/demo/link_scroll_menu/jd_link_scroll_menu.dart';
import 'package:jd_core/jd_core.dart';

/**
 *
 * @author jd
 *
 */

class ThirdpartyListPage extends StatefulWidget {
  final String title = "jd_thirdparty_list";

  @override
  State createState() => _ThirdpartyListPageState();
}

class _ThirdpartyListPageState extends State<ThirdpartyListPage> {
  /*************************** demo.thirdpary *************************/
  final thirdpary_list = <Map<String, dynamic>>[
    {
      'title': 'StackedCard',
      'router': '/stacked_card',
    },
    {
      "title": "WebView",
      "router": "/webview",
    },
    {
      'title': '拍照',
      'router': '/pickImage',
    },
    {
      "title": "Camera",
      "router": "/camera",
    },
    {
      "title": "Player",
      "router": "/player",
    },
    {
      'title': 'LinkScrollMenu',
      'router': JDLinkScrollMenu(),
    },
    {
      'title': 'Book',
      'router': BookPage(),
    },
    {
      'title': 'fishredux',
      'router': OnePagePage().buildPage({}),
    },
  ];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
        itemCount: thirdpary_list.length * 2,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildRow(thirdpary_list[index]);
        });
  }

  Widget _buildRow(Map<String, dynamic> map) {
    String text = map["title"].toString();
    return new ListTile(
      contentPadding: EdgeInsets.all(10.0),
      title: new Text(
        text,
        style: _biggerFont,
      ),
      leading: new Image.asset("assets/images/head.png"),
      onTap: () {
        _pushSaved(text, map["router"]);
      },
    );
  }

  void _pushSaved(String title, dynamic router) async {
    if (router != null && router is Widget) {
      JDNavigationUtil.push(router);
      return;
    }

    // Navigator.pushNamed(context, router);
    //带有返回值
    var map = await Navigator.of(context)
        .pushNamed(router, arguments: {"title": title});
    debugPrint(map.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Component List"),
      ),
      body: _buildSuggestions(),
    );
  }
}
