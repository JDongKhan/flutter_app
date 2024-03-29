import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_component/pages/logistics/logistics_page.dart';
import 'package:flutter_app_component/pages/logistics/widget/ace_stepper.dart';
import 'package:flutter_app_component/pages/setting/setting_page.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import 'member_home_page.dart';

/**
 *
 * @author jd
 *
 */

mixin _CounterStateMixin<T extends StatefulWidget> on State<T> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}

class MyPage extends StatefulWidget {
  final String title = "我的";

  @override
  State createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with _CounterStateMixin, AutomaticKeepAliveClientMixin {
  int _appBarStyle = 0;
  bool _showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _controller = new ScrollController();

  final _headMenu = [
    {'icon': Icons.favorite, 'title': "我的收藏"},
    {'icon': Icons.center_focus_strong, 'title': "我的关注"},
    {
      'icon': Icons.border_horizontal,
      'title': "足迹",
    },
    {'icon': Icons.contact_phone, 'title': "优惠券"}
  ];

  var gridMenu = [
    {'icon': Icons.assignment, 'title': '发票'},
    {'icon': Icons.contact_phone, 'title': '客服'},
    {'icon': Icons.border_color, 'title': '意见反馈'},
    {'icon': Icons.help, 'title': '帮助'},
    {'icon': Icons.room_service, 'title': '服务估价'},
    {'icon': Icons.people, 'title': '合作伙伴'},
    {'icon': Icons.color_lens, 'title': '我的余额'},
    {'icon': Icons.search, 'title': '免费核名'},
    {'icon': Icons.class_, 'title': '分类'},
    {'icon': Icons.search, 'title': '查询'},
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _controller.offset;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStyle0AppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      centerTitle: true,
      brightness: Brightness.dark,
      leading: _buildLeading(),
      actions: _buildAction(),
      title: InkWell(
        onTap: () {
          setState(() {
            _appBarStyle = _appBarStyle == 0 ? 1 : 0;
          });
        },
        child: const Text(
          '我的',
          style: TextStyle(color: Colors.white),
        ),
      ),
      elevation: 2,
      pinned: true,
//      floating: true,
//      snap: true,
      backgroundColor: Colors.blue[100],
      flexibleSpace: FlexibleSpaceBar(
        //视差效果
        collapseMode: CollapseMode.parallax,
        background: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Image.asset(
              JDAssetBundle.getImgPath('user_head'),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            _buildMesnuGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildStyle1AppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250.0,
      backgroundColor: Colors.blue[100],
      leading: _buildLeading(),
      actions: _buildAction(),
      flexibleSpace: FlexibleSpaceBar(
        title: InkWell(
          onTap: () {
            setState(() {
              _appBarStyle = _appBarStyle == 0 ? 1 : 0;
            });
          },
          child: const Text(
            '我的',
            style: TextStyle(color: Colors.white),
          ),
        ),
        background: Image.asset(
          JDAssetBundle.getImgPath("user_head"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            JDNavigationUtil.push(MemberHomePage());
          },
          child: Image.asset(JDAssetBundle.getImgPath('head')),
        ),
      );

  List<Widget> _buildAction() => <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: _appBarStyle == 0 ? Colors.white : Colors.black12,
          ),
          onPressed: () {
            JDNavigationUtil.push(SettingPage());
          },
        )
      ];

  Widget _buildMesnuGrid() {
    return Container(
      height: 90,
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        children: _headMenu
            .map((e) => Container(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Tab(
                      icon: Icon(
                        e['icon'] as IconData,
                        color: Colors.white,
                      ),
                      child: Text(
                        e['title'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildOrder() {
    return SliverToBoxAdapter(
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    '我的订单',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: FlatButton(
                    child: Row(
                      children: const <Widget>[
                        Text(
                          '详情',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading: Image.asset(
                JDAssetBundle.getImgPath('head'),
                width: 40,
                height: 40,
              ),
              title: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: const Text(
                  '发布需求',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              subtitle: const Text(
                '免费获取方案和报价',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black54),
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Text(
                  '立即获取',
                  style: TextStyle(fontSize: 12),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFAAAAAA)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return SliverToBoxAdapter(
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    '常用功能',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            GridView.count(
              crossAxisCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(0),
              childAspectRatio: 1,
              shrinkWrap: true, //解决gridview不能在customScrollView显示的问题
              children: gridMenu.map((item) => _getItem(item)).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _getItem(Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        if (item['title'] == '查询') {
          bool v = Random().nextInt(100) % 2 == 0;
          JDNavigationUtil.push(ACEStepperPage(
            type:
                v == true ? ACEStepperType.vertical : ACEStepperType.horizontal,
          ));
        }
      },
      child: Tab(
        icon: Icon(item['icon'] as IconData),
        child: Text(
          item['title'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildRecommend() {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 10),
        child: const Text(
          '--- 为您推荐-人气店铺 ---',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildList() {
    return SliverFixedExtentList(
      itemExtent: 80.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        //创建列表项
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('list item $index'),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        );
      }, childCount: 30 //50个列表项
          ),
    );
  }

  void _onScroll(double offset) {
    if (offset < 1000 && _showToTopBtn) {
      setState(() {
        _showToTopBtn = false;
      });
    } else if (offset >= 1000 && _showToTopBtn == false) {
      setState(() {
        _showToTopBtn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NotificationListener<Notification>(
          onNotification: (Notification scrollNotification) {
            if ((scrollNotification is ScrollUpdateNotification) &&
                (scrollNotification.depth == 0)) {
              _onScroll(scrollNotification.metrics.pixels);
            }
            return true;
          },
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.grey[200],
              ),
              CustomScrollView(
                controller: _controller,
                slivers: <Widget>[
                  //AppBar，包含一个导航栏
                  if (_appBarStyle == 0)
                    _buildStyle0AppBar()
                  else
                    _buildStyle1AppBar(),

                  SliverPadding(
                    padding: const EdgeInsets.only(top: 10),
                    sliver: _buildOrder(),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.only(top: 10),
                    sliver: _buildMenu(),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.only(top: 10),
                    sliver: _buildRecommend(),
                  ),
                  _buildList(),
                ],
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
