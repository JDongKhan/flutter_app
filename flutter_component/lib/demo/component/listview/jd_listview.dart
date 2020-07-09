import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/demo/component/listview/azlist.dart';
import 'package:flutter_component/utils/jd_navigation_util.dart';

/**
 *
 * @author jd
 *
 */

class JDListViewPage extends StatefulWidget {
  final String title = "listview";

  @override
  State createState() => _JDListViewPageState();
}

class _JDListViewPageState extends State<JDListViewPage> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          ListTile(title: Text("单词列表")),
          Expanded(
            child: ListView.separated(
              itemCount: _words.length,
              itemBuilder: (context, index) {
                //如果到了表尾
                if (_words[index] == loadingTag) {
                  //不足100条，继续获取数据
                  if (_words.length - 1 < 100) {
                    //获取数据
                    _retrieveData();
                    //加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(strokeWidth: 2.0)),
                    );
                  } else {
                    //已经加载了100条数据，不再获取数据。
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ));
                  }
                }
                //显示单词列表项
                return InkWell(
                  onTap: () {
                    JDNavigationUtil.push(CitySelectRoute());
                  },
                  child: ListTile(title: Text(_words[index])),
                );
              },
              separatorBuilder: (context, index) => Divider(height: .0),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _retrieveData() {
    Future<dynamic>.delayed(Duration(seconds: 2)).then((dynamic e) {
      _words.insertAll(
          _words.length - 1,
          //每次生成20个单词
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        //重新构建列表
      });
    });
  }
}
