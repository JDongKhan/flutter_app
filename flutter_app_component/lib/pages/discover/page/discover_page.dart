import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/mask/bubble_widget.dart';
import 'package:flutter_app_component/component/mask/mask_widget.dart';
import 'package:flutter_app_component/global/widget_config.dart';
import 'package:jd_core/style/jd_styles.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import '../vm/discover_controller.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ///业务controller
  final DiscoverController _controller = DiscoverController();
  final ScrollController _rightScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  List<MarkEntry> _entryList() {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MarkWidget(
      entryList: _entryList(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: myAppBar(
          title: const Text(
            '发现',
            style: TextStyle(color: Colors.black),
          ),
          leading: homeButtonIcon(context, color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: <Widget>[
            ///分享按钮
            shareButtonIcon(context, color: Colors.black),
            //菜单按钮
            PopupMenuButton<String>(
              color: Colors.white,
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
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
      ),
    );
  }

  ///body
  Widget _buildSuggestions() {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _buildLeftMenu(),
          Expanded(
            child: _buildRightMenu(),
          ),
        ],
      ),
    );
  }

  ///左边菜单
  Widget _buildLeftMenu() {
    return Container(
      width: 100,
      color: Colors.grey[100],
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: _controller.moduleList.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(_controller.moduleList[i], i);
        },
      ),
    );
  }

  ///左侧行
  Widget _buildRow(Map<String, dynamic> map, int index) {
    final String text = map['title'];
    return InkWell(
      child: Container(
        color: Colors.white,
        child: Container(
          alignment: Alignment.centerLeft,
          height: 40,
          decoration: BoxDecoration(
            color: index == _controller.currentIndex
                ? Colors.white
                : Colors.grey[100],
            borderRadius: _borderRadius(index),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              color: index == _controller.currentIndex
                  ? Colors.blue
                  : Colors.black,
            ),
          ),
        ),
      ),
      onTap: () {
        _rightScrollController.jumpTo(0);
        setState(() {
          _controller.currentIndex = index;
        });
      },
    );
  }

  ///圆角
  BorderRadius _borderRadius(int index) {
    if (index == _controller.currentIndex + 1) {
      return const BorderRadius.only(topRight: Radius.circular(10));
    }
    if (index == _controller.currentIndex - 1) {
      return const BorderRadius.only(bottomRight: Radius.circular(10));
    }
    return null;
  }

  ///右边菜单
  Widget _buildRightMenu() {
    final Map map = _controller.moduleList[_controller.currentIndex];
    final List currentList = map['items'];
    return Container(
      // color: Colors.grey[100],
      child: ListView.separated(
        controller: _rightScrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: currentList?.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          final Map item = currentList[i];
          final String text = item['title'];
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
          return Divider(
            height: 1,
            color: Colors.grey[100],
          );
        },
      ),
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

  ///下载
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

  ///跳转
  void _pushSaved(String title, String router, Widget page) {
    if (page != null) {
      JDNavigationUtil.push(page);
      return;
    }

    // Navigator.pushNamed(context, router);
    var map = JDNavigationUtil.pushNamed(router, arguments: {'title': title});
    //带有返回值
//    var map = await Navigator.of(context).pushNamed(router, arguments: {'title' : title});
//     debugPrint(map.toString());

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
  bool get wantKeepAlive => true;
}
