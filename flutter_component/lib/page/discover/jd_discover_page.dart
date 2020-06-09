import 'package:flutter/material.dart';
import 'package:flutter_component/demo/router/jd_route.dart';
import 'package:flutter_component/page/scaffold/jd_scaffold_page.dart';
import 'package:flutter_component/utils/jd_navigation_util.dart';
import 'package:flutter_component/routes/jd_routes.dart';

class JDDiscoverPage  extends StatefulWidget {
  @override
  State createState() => _JDDiscoverPageState();
}

class _JDDiscoverPageState extends State<JDDiscoverPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  final _biggerFont = const TextStyle(fontSize: 18.0);

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSuggestions() {

    //下划线widget预定义以供复用。
    Widget divider1=Divider(color: Colors.blue,);
    Widget divider2=Divider(color: Colors.green);

    return new ListView.separated(
        itemCount: module_list.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRow(module_list[i]);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return index%2==0?divider1:divider2;
        },
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
    var map =  JDNavigationUtil.pushNamed(router,arguments: {"title" : title});
    //带有返回值
//    var map = await Navigator.of(context).pushNamed(router, arguments: {"title" : title});
    print(map);

//
//  //此种方法可传参
//    Navigator.of(context).push(
//      new MaterialPageRoute(
//        builder: (context) {
//          return new NetworkPage();
//        },
//      ),
//    );

//    Navigator.of(context).pushNamed(router);
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 1,//隐藏底部阴影
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
            '发现',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.home,color: Colors.white,),
          onPressed: (){
            JDScaffoldPage.of(context).switchTabbarIndex(0);
          }),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share,color: Colors.white),
            onPressed: (){
              final snackBar = SnackBar(
                content: Text("我是提示文本"),
                backgroundColor: Colors.green,
                duration: Duration(milliseconds: 5000),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: '取消',
                  onPressed: (){

                  },
                ),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
            tooltip: '分享',
          ),
          //菜单按钮
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(Icons.more_horiz,color: Colors.white,),
            onSelected:(item) {
              print(item);
            },
            itemBuilder: (context) => <PopupMenuItem<String>> [
              //菜单项
              PopupMenuItem<String>(
                value: 'friend',
                child: Text('分享到朋友圈'),
              ),
              PopupMenuItem<String>(
                value: 'download',
                child: Text('下载到本地'),
              ),
            ],
          )
        ],
      ),
      body: _buildSuggestions(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;
}
