import 'package:flutter/material.dart';

class TabbarPage extends StatefulWidget {
  @override
  _JDTabbarPageState createState() => _JDTabbarPageState();
}

class _JDTabbarPageState extends State<TabbarPage> {
  final list = <Map<String, String>>[
    {'title': '精选', 'content': '我是谁'},
    {'title': '猜你喜欢', 'content': '我是谁'},
    {'title': '母婴', 'content': '我是谁'},
    {'title': '儿童', 'content': '我是谁'},
    {'title': '女装', 'content': '我是谁'},
    {'title': '百货', 'content': '我是谁'},
    {'title': '美食', 'content': '我是谁'},
    {'title': '美妆', 'content': '我是谁'},
    {'title': '其他', 'content': '我是谁'}
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: list.length,
      child: Scaffold(
        appBar: AppBar(
          primary: true, //为false的时候会影响leading，actions、titile组件，导致向上偏移
          textTheme: TextTheme(//设置AppBar上面各种字体主题色
//            title: TextStyle(color: Colors.red),
              ),
          actionsIconTheme: IconThemeData(
              color: Colors.blue,
              opacity: 0.6), //设置导航右边图标的主题色，此时iconTheme对于右边图标颜色会失效
          iconTheme: IconThemeData(
              color: Colors.black, opacity: 0.6), //设置AppBar上面Icon的主题颜色
          brightness: Brightness.dark, //设置导航条上面的状态栏显示字体颜色
          backgroundColor: Colors.amber, //设置背景颜色
//          shape: CircleBorder(side: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid)),//设置appbar形状
//          automaticallyImplyLeading: true,//在leading为null的时候失效

//          bottom: PreferredSize(child: Text('data'), preferredSize: Size(30, 30)),//出现在导航条底部的按钮
          bottom: TabBar(
            onTap: (int index) {
              print('Selected......$index');
            },
            unselectedLabelColor: Colors.black, //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
            unselectedLabelStyle:
                TextStyle(fontSize: 20), //设置未选中时的字体样式，tabs里面的字体样式优先级最高
            labelColor: Colors.red, //设置选中时的字体颜色，tabs里面的字体样式优先级最高
            labelStyle: TextStyle(
                fontSize: 25.0,
                color: Colors.blue), //设置选中时的字体样式，tabs里面的字体样式优先级最高
            isScrollable: true, //允许左右滚动
            indicatorColor: Colors.red, //选中下划线的颜色
            indicatorSize: TabBarIndicatorSize
                .label, //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
            indicatorWeight: 3.0, //选中下划线的高度，值越大高度越高，默认为2。0
//                indicator: BoxDecoration(),//用于设定选中状态下的展示样式
            tabs: list
                .map((e) => Text(
                      e["title"],
                      // style: TextStyle(color: Colors.green, fontSize: 16.0),
                    ))
                .toList(),
          ),
          centerTitle: true,
          title: const Text('AppBar Demo'),
          leading: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                print('add click....');
              }),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print('search....');
                }),
            IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {
                  print('history....');
                }),
          ],
        ),
        body: TabBarView(
          children:
              list.map((e) => Text("${e['content']}-${e['title']}")).toList(),
        ),
      ),
    );
  }
}
