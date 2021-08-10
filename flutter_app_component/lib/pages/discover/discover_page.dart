import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/mask/bubble_widget.dart';
import 'package:flutter_app_component/component/mask/mask_widget.dart';
import 'package:flutter_app_component/pages/scaffold/scaffold_page.dart';
import 'package:jd_core/style/jd_styles.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/utils/jd_share_utils.dart';

import 'discover_controller.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ///业务controller
  final DiscoverController _controller = DiscoverController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    ///显示蒙版提示
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MarkUtils.showMark(context, [
        MarkEntry(
          widget: BubbleWidget(
            child: const Text(
              '标题',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          left: 100,
          top: 80,
        ),
        MarkEntry(
          widget: BubbleWidget(
            position: BubbleArrowDirection.right,
            child: const Text(
              '内容',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          left: 100,
          top: 100,
        ),
        MarkEntry(
          widget: BubbleWidget(
            position: BubbleArrowDirection.left,
            child: const Text(
              '列表',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          left: 10,
          top: 200,
        ),
      ]);
    });
  }

  Widget _buildLeftMenu() {
    //下划线widget预定义以供复用。
    const Widget divider1 = Divider(
      height: 1,
      color: Colors.blue,
    );
    return Container(
      width: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: _controller.module_list.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(_controller.module_list[i], i);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return divider1;
        },
      ),
    );
  }

  Widget _buildRightMenu() {
    Map map = _controller.module_list[_controller.currentIndex];
    List currentList = map['items'];
    return Container(
      color: Colors.grey[100],
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: currentList?.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          Map item = currentList[i];
          String text = item['title'];
          return InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            onTap: () {
              _pushSaved(text, item['router'], item['page']);
            },
          );
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            color: Colors.blue,
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return Row(
      children: <Widget>[
        _buildLeftMenu(),
        Expanded(
          child: _buildRightMenu(),
        ),
      ],
    );
  }

  Widget _buildRow(Map<String, dynamic> map, int index) {
    final String text = map['title'];
    return InkWell(
      child: Container(
        color:
            index == _controller.currentIndex ? Colors.grey[100] : Colors.white,
        alignment: Alignment.centerLeft,
        height: 40,
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14.0),
        ),
      ),
      onTap: () {
        setState(() {
          _controller.currentIndex = index;
        });
      },
    );
  }

  void _pushSaved(String title, String router, Widget page) async {
    if (page != null) {
      JDNavigationUtil.push(page);
      return;
    }

    // Navigator.pushNamed(context, router);
    var map = JDNavigationUtil.pushNamed(router, arguments: {'title': title});
    //带有返回值
//    var map = await Navigator.of(context).pushNamed(router, arguments: {'title' : title});
    debugPrint(map.toString());

//
//  //此种方法可传参
//    Navigator.of(context).push(
//      new CupertinoPageRoute(
//        builder: (context) {
//          return new NetworkPage();
//        },
//      ),
//    );

//    Navigator.of(context).pushNamed(router);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: myAppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          '发现',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              ScaffoldPage.of(context).switchTabbarIndex(0);
            }),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              showShareBottomSheet(context);
              return;
              final snackBar = SnackBar(
                content: const Text('我是提示文本'),
                backgroundColor: Colors.green,
                duration: const Duration(milliseconds: 5000),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: '取消',
                  onPressed: () {},
                ),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
            tooltip: '分享',
          ),
          //菜单按钮
          PopupMenuButton<String>(
            color: Colors.white,
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            onSelected: (String item) {
              if (item == 'download') {
                _download();
              } else {
                _share();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              //菜单项
              const PopupMenuItem<String>(
                value: 'friend',
                child: Text('分享到朋友圈'),
              ),
              const PopupMenuItem<String>(
                value: 'download',
                child: Text('下载到本地'),
              ),
            ],
          )
        ],
      ),
      body:
          _buildSuggestions(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _share() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: const Text('提示'),
            message: const Text('是否继续分享？'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: const Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  void _download() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {},
              ),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
