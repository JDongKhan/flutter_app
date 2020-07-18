import 'package:flutter/material.dart';
import 'package:flutter_component/widget/searchbar/jd_searchbar.dart';
import 'package:flutter_component/widget/sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';

/// @author jd

class JDNestedScrollView4Demo extends StatefulWidget {
  @override
  _JDNestedScrollView4DemoState createState() =>
      _JDNestedScrollView4DemoState();
}

class _JDNestedScrollView4DemoState extends State<JDNestedScrollView4Demo> {
  List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {
      'title': '热点',
    },
    {
      'title': '地方',
    },
    {
      'title': '直播',
    },
    {'title': '社会'}
  ];

  List _data_menus = [
    {'title': '菜单一', 'img': ''},
    {'title': '菜单二', 'img': ''},
    {'title': '菜单三', 'img': ''},
    {'title': '菜单四', 'img': ''},
    {'title': '菜单五', 'img': ''},
    {'title': '菜单六', 'img': ''},
    {'title': '菜单七', 'img': ''},
    {'title': '全部', 'img': ''},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: _buildScaffoldBody(context),
      ),
    );
  }

  Widget _buildScaffoldBody(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    ///轮播图高度
    double _swiperHeight = 326 + 10.0;

    ///提示头部高度
    double _spikeHeight = 80;

    ///_appBarHeight算的是AppBar的bottom高度，kToolbarHeight是APPBar高，statusBarHeight是状态栏高度
    double _appBarHeight =
        _swiperHeight + _spikeHeight - kToolbarHeight - statusBarHeight;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

            ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
            ///所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
            sliver: SliverAppBar(
              forceElevated: innerBoxIsScrolled,
              title: _widget_barSearch(),
              centerTitle: true,
              pinned: true,
              elevation: 0,
              expandedHeight: 250,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.business),
                )
              ],

              ///TabBar顶部收缩的部分
              flexibleSpace: Stack(
                children: <Widget>[
                  _navigationBarBackground(),
                  _widgetMenuCard(),
                ],
              ),
            ),
          ),

          ///停留在顶部的TabBar
          SliverPersistentHeader(
            delegate: JDSliverPersistentHeaderDelegate(60, 80, _tabBar()),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        children: _tabs.map((e) => _listItem(_tabs.indexOf(e))).toList(),
      ),
    );
  }

  /************************** 导航 **************************/
  //顶部搜索框
  Widget _widget_barSearch() {
    return Container(
      child: JDSearchBar(
        text: '搜索你想要的',
        onTap: () {},
      ),
    );
  }

  Widget _navigationBarBackground() {
    return Container(
      color: Colors.blue,
    );
  }

  Widget _widgetMenuCard() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(
        top: kToolbarHeight + statusBarHeight,
      ),
      child: Card(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: _data_menus.map((v) {
            return _widgetMenuItem(v);
          }).toList(),
        ),
      ),
    );
  }

  Widget _widgetMenuItem(Map v) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 - 4,
      child: FlatButton(
        onPressed: null,
        child: Container(
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                child: CircleAvatar(
                  radius: 20.0,
                  child: Icon(Icons.invert_colors, color: Colors.white),
                  backgroundColor: const Color(0xFFB88800),
                ),
              ),
              Container(
                child: Text(v['title'],
                    style: TextStyle(
                        fontSize: 14.0, backgroundColor: Colors.yellow)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /************************** tabbar **************************/

  Widget _tabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        //生成Tab菜单
        tabs: _tabs.map((e) => Tab(text: e['title'])).toList(),
      ),
    );
  }

  /************************** content **************************/

  Widget _listItem(int index) {
    return Container(
      color: Colors.grey[100],
      margin: const EdgeInsets.only(top: 80),
      key: PageStorageKey<int>(index),
      child: ListView.separated(
        padding: const EdgeInsets.all(0), //目的让内容对齐，不留空隙
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 60,
            padding: const EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              '我是第$index行',
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: 100,
      ),
    );
  }
}
