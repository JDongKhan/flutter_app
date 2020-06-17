import 'package:flutter/material.dart';

class JDDemoListPage extends StatefulWidget {
  @override
  State createState() => _JDDemoListPageState();
}

class _JDDemoListPageState extends State<JDDemoListPage> {
  /*************************** demo *************************/

  final demo_list = <Map<String, String>>[
    {
      "title": "Login",
      "router": "/login",
    },
    {
      "title": "Scaffold",
      "router": "/scaffold",
    },
    {
      "title": "Tabbar",
      "router": "/tabbar",
    },
    {
      "title": "抖音",
      "router": "/douyin",
    },
    {
      "title": "购物车",
      "router": "/buy_car",
    },
    {
      "title": "拍照",
      "router": "/pickImage",
    },
    {
      "title": "第三方组件",
      "router": "/thirdparty_list",
    }
  ];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        itemCount: demo_list.length * 2,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildRow(demo_list[index]);
        });
  }

  Widget _buildRow(Map<String, String> map) {
    String text = map["title"];
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

  void _pushSaved(String title, String router) async {
    // Navigator.pushNamed(context, router);
    //带有返回值
    var map = await Navigator.of(context)
        .pushNamed(router, arguments: {"title": title});
    print(map);
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
