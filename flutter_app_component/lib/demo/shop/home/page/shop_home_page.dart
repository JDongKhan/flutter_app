import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/shop/detail/page/shop_detail_page.dart';
import 'package:flutter_app_component/demo/shop/home/vm/shop_home_vm.dart';
import 'package:flutter_app_component/demo/shop/home/widget/shop_home_appbar.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:flutter_app_component/demo/shop/shop_main_page.dart';
import 'package:flutter_app_component/demo/wechat/message_list/message_list/widget/wechat_message_list_bottom_menu.dart';
import 'package:flutter_app_component/global/widget_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:jd_core/jd_core.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'shop_home_product_list_page.dart';
import 'shop_home_product_list_page_1.dart';

/// @author jd

class ShopHomePage extends StatefulWidget {
  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final ShopHomeVM _vm = Get.put(ShopHomeVM());
  TabController _tabController;
  double _offset = 0;
  final WeChatMessageListBottomMenuController _bottomMenuController =
      WeChatMessageListBottomMenuController(animal: true);

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _vm.tabs.value.length);

    _vm.loadData().then((value) {
      _tabController =
          TabController(vsync: this, length: _vm.tabs.value.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeChatMessageListBottomMenu(
          controller: _bottomMenuController,
          onBack: () {
            _showMainPage();
          },
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          transform: Matrix4.translationValues(0.0, _offset, 0.0),
          child: _refreshWidget(
            child: Obx(
              () => NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  List<Widget> headerSlivers = [];

                  //下拉刷新
                  headerSlivers.add(PullToRefreshContainer(
                    (info) => buildPulltoRefreshImage(context, info),
                  ));

                  //导航
                  headerSlivers.add(
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),

                      ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
                      sliver: ShopHomeAppBar(
                        backgroundColor: Colors.blue,
                        title: const Text(
                          '生产有限公司',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        centerTitle: false,
                        expandedHeight: 140.0,
                        brightness: Brightness.light,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(60),
                          child: _buildSearch(),
                        ),
                        // leading: const IconButton(
                        //   icon: Icon(
                        //     Icons.home,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        actions: const <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.business,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                  //空隙
                  headerSlivers.add(
                    const SliverToBoxAdapter(
                      child: SafeArea(
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                    ),
                  );

                  //轮播图
                  headerSlivers.add(SliverToBoxAdapter(child: _buildSwiper()));

                  //菜单
                  headerSlivers
                      .add(SliverToBoxAdapter(child: _buildGridView()));

                  if (_vm.tabs.isNotEmpty) {
                    //tab菜单
                    headerSlivers.add(_buildPersistentHeader());
                  }
                  return headerSlivers;
                },
                body: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _vm.tabs
                      .map(
                        (e) => _buildContentPage(e),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentPage(Map e) {
    final int index = _vm.tabs.indexOf(e);
    if (index == 1) {
      return ShopHomeProductListPage1(
        keyword: e['title'].toString(),
      );
    }
    return ShopHomeProductListPage(
      keyword: e['title'].toString(),
    );
  }

  void hiddenBottomBar(bool hidden) {
    ShopMainPage.of(context).hiddenBottomNavigationBar(hidden);
  }

  //显示主页面
  void _showMainPage() {
    hiddenBottomBar(false);
    setState(() {
      _offset = 0;
      _bottomMenuController.opacity = 0;
    });
  }

  Future<bool> _onRefresh() async {
    print('开始刷新了');
    // _globalKey.currentState.show(notificationDragOffset: 200);
    await _vm.onRefresh();
    setState(() {
      _offset = jd_screenHeight();
      _bottomMenuController.opacity = 1;
      hiddenBottomBar(true);
    });
    return true;
  }

  ///刷新
  Widget _refreshWidget({Widget child}) {
    const bool refreshEnable = true;
    if (refreshEnable) {
      return PullToRefreshNotification(
        color: Theme.of(context).canvasColor,
        // pullBackOnRefresh: true,
        onRefresh: _onRefresh,
        armedDragUpCancel: false,
        maxDragOffset: 200,
        child: child,
      );
    }
    return child;
  }

  ///Search
  Widget _buildSearch() {
    return Container(
      // color: Colors.red,
      // height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      child: JDSearchBar(
        text: _vm.searchText,
        onTap: () {},
      ),
    );
  }

  ///Swiper
  Widget _buildSwiper() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Swiper(
        itemCount: 5,
        autoplay: true,
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red, color: Colors.green)),
        itemBuilder: (BuildContext context, int index) {
          if (index % 2 == 0) {
            return Image.asset(
              JDAssetBundle.getImgPath('bg_0', format: 'jpg'),
              fit: BoxFit.fill,
            );
          }
          return Image.asset(
            JDAssetBundle.getImgPath('bg_1', format: 'jpg'),
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  ///GridView
  Widget _buildGridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            left: 10,
            bottom: 10,
          ),
          child: const Text(
            '常购清单',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Container(
          height: 180,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, //每行三列
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.4 //显示区域宽高相等
                  ),
              itemCount: _vm.recommendList.length,
              itemBuilder: (context, index) {
                ShopInfo shopInfo = _vm.recommendList[index];
                //如果显示到最后一个并且Icon总数小于200时继续获取数据
                return _buildGirdItem(shopInfo);
              }),
        ),
      ],
    );
  }

  ///GridItem
  Widget _buildGirdItem(ShopInfo shopInfo) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ShopDetailPage(shopInfo);
        }));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                // color: Colors.red,
                alignment: Alignment.center,
                child: Image.asset(
                  shopInfo.icon,
                  // fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 5,
                ),
                child: Text(
                  shopInfo.shop_name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Text('￥${shopInfo.price}')),
          ],
        ),
      ),
    );
  }

  ///tabbar
  Widget _buildPersistentHeader() => SliverPersistentHeader(
        pinned: true,
        delegate: JDSliverPersistentHeaderDelegate(
            40,
            60,
            Container(
              color: Colors.grey[100],
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                // These are the widgets to put in each tab in the tab bar.
                tabs:
                    _vm.tabs.map((Map map) => Tab(text: map['title'])).toList(),
              ),
            )),
      );

  @override
  bool get wantKeepAlive => true;
}
