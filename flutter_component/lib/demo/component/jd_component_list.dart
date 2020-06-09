import 'package:flutter/material.dart';
import 'package:flutter_component/routes/jd_routes.dart';

class JDComponentListPage extends StatefulWidget {

  @override
  State createState() => _JDComponentListPageState();

}

class _JDComponentListPageState extends State<JDComponentListPage>  {



  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        itemCount: component_list.length * 2,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();
          final  index = i ~/ 2;
          return _buildRow(component_list[index]);
        }
    );
  }

  Widget _buildRow(Map<String,String> map) {
    String text = map["title"];
    return new ListTile(
      contentPadding: EdgeInsets.all(10.0),
      title: new Text(
        text,
        style: _biggerFont,
      ),
      leading: new Image.asset("assets/images/head.png"),
      onTap: () {
        _pushSaved(text,map["router"]);
      },
    );
  }


  void _pushSaved(String title, String router) async {
    // Navigator.pushNamed(context, router);
    //带有返回值
    var map = await Navigator.of(context).pushNamed(router, arguments: {"title" : title});
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
