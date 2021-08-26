import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/my/vm/shop_my_vm.dart';
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
  final ShopMyVm _shopMyVm = ShopMyVm();
  int _appBarStyle = 0;
  bool _showToTopBtn = false; //是否显示“返回到顶部”按钮
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
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
      leading: _buildLeading(),
      actions: _buildAction(),
      backgroundColor: Colors.blue[100],
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
          JDAssetBundle.getImgPath('user_head'),
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
              child: Image.asset(JDAssetBundle.getImgPath('head')),
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
        children: _shopMyVm.headMenu
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
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(0),
              childAspectRatio: 1,
              shrinkWrap: true, //解决gridview不能在customScrollView显示的问题
              children:
                  _shopMyVm.orderMenu.map((item) => _getItem(item)).toList(),
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
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    '常用功能',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              children:
                  _shopMyVm.gridMenu.map((item) => _getItem(item)).toList(),
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
          style: const TextStyle(fontSize: 12),
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
    super.build(context);
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
