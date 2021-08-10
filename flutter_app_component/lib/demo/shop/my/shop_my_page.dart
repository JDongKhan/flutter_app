import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/pages/logistics/logistics_page.dart';
import 'package:flutter_app_component/pages/logistics/widget/ace_stepper.dart';
import 'package:flutter_app_component/pages/my/member_home_page.dart';
import 'package:flutter_app_component/pages/setting/setting_page.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class ShopMyPage extends StatefulWidget {
  @override
  _ShopMyPageState createState() => _ShopMyPageState();
}

class _ShopMyPageState extends State<ShopMyPage>
    with AutomaticKeepAliveClientMixin {
  int _appBarStyle = 0;
  bool _showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _controller = new ScrollController();

  final _headMenu = [
    {'icon': Icons.memory, 'title': "钻石"},
    {'icon': Icons.filter_center_focus, 'title': "关注"},
    {
      'icon': Icons.border_horizontal,
      'title': "足迹",
    },
    {'icon': Icons.contact_phone, 'title': "优惠券"}
  ];

  var _orderMenu = [
    {
      'icon': Icons.payment,
      'title': '待支付',
    },
    {
      'icon': Icons.send,
      'title': '待发货',
    },
    {
      'icon': Icons.receipt,
      'title': '待收货',
    },
    {
      'icon': Icons.comment,
      'title': '待评价',
    },
    {
      'icon': Icons.backpack,
      'title': '退款/售后',
    },
  ];
  var gridMenu = [
    {'icon': Icons.assignment, 'title': '发票'},
    {'icon': Icons.contact_phone, 'title': '客服'},
    {'icon': Icons.border_color, 'title': '意见反馈'},
    {'icon': Icons.help, 'title': '帮助'},
    {'icon': Icons.people, 'title': '合作伙伴'},
    {'icon': Icons.color_lens, 'title': '我的余额'},
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
      leading: _buildLeading(),
      actions: _buildAction(),
      title: InkWell(
        onTap: () {
          setState(() {
            _appBarStyle = (_appBarStyle == 0 ? 1 : 0);
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
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //视差效果
        collapseMode: CollapseMode.parallax,
        background: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Image.asset(
              JDAssetBundle.getImgPath("user_head"),
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
      leading: _buildLeading(),
      actions: _buildAction(),
      flexibleSpace: FlexibleSpaceBar(
        title: InkWell(
          onTap: () {
            setState(() {
              _appBarStyle = (_appBarStyle == 0 ? 1 : 0);
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
        child: Row(
          children: [
            InkWell(
              onTap: () {
                JDNavigationUtil.push(MemberHomePage());
              },
              child: Image.asset(JDAssetBundle.getImgPath("head")),
            ),
          ],
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
                        style: const TextStyle(color: Colors.white),
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
            Container(
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    '我的订单',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Row(
                        children: const <Widget>[
                          Text('查看全部'),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            GridView.count(
              crossAxisCount: 5,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(0),
              childAspectRatio: 1,
              shrinkWrap: true, //解决gridview不能在customScrollView显示的问题
              children: _orderMenu.map((item) => _getItem(item)).toList(),
            )
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
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '常用功能',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(),
            GridView.count(
              crossAxisCount: 4,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(0),
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
        text: item['title'].toString(),
      ),
    );
  }

  Widget _buildRecommend() {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '--- 为您推荐-人气商品 ---',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return SliverGrid(
      //Grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //Grid按两列显示
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          //创建子widget
          return _buildProductItem(index);
        },
        childCount: 60,
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
      child: NotificationListener(
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
                  _appBarStyle == 0
                      ? _buildStyle0AppBar()
                      : _buildStyle1AppBar(),

                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: _buildOrder(),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: _buildMenu(),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: _buildRecommend(),
                  ),
                  _buildGrid(),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildProductItem(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Image.asset(
                  JDAssetBundle.getImgPath('shop_${index % 5}'),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  top: 5,
                ),
                child: const Text(
                  '商品名称',
                  maxLines: 2,
                )),
            Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                child: const Text('￥100')),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
