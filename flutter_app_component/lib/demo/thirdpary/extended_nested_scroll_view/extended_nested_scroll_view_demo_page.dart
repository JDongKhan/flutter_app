import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_app_component/demo/shop/detail/page/shop_detail_page.dart';
import 'package:flutter_app_component/demo/shop/home/page/shop_home_product_list_page.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:flutter_app_component/global/widget_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/widget/searchbar/jd_searchbar.dart';
import 'package:jd_core/widget/sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

/// @author jd

class ExtendedNestedScrollViewDemoPage extends StatefulWidget {
  @override
  _ExtendedNestedScrollViewDemoPageState createState() =>
      _ExtendedNestedScrollViewDemoPageState();
}

class _ExtendedNestedScrollViewDemoPageState
    extends State<ExtendedNestedScrollViewDemoPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<PullToRefreshNotificationState> _globalKey =
      GlobalKey<PullToRefreshNotificationState>();
  TabController _tabController;
  String _searchText;
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {
      'title': '推荐',
      'key': 'Tab0',
    },
    {
      'title': '投影仪',
      'key': 'Tab1',
    },
    {
      'title': '家用电器',
      'key': 'Tab2',
    },
    {
      'title': '服装',
      'key': 'Tab3',
    },
    {
      'title': '冰箱',
      'key': 'Tab4',
    },
    {
      'title': '其他',
      'key': 'Tab5',
    },
  ];

  final List<ShopInfo> _recommendList = [
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_0'),
      shop_name: '洗发水-你值得拥有',
      price: 18.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_1'),
      shop_name: '蛋糕-好吃到爆',
      price: 8.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_2'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_3'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_4'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabs.length);
    super.initState();
  }

  Future<bool> _onRefresh() async {
    print('开始刷新了');
    // _globalKey.currentState.show(notificationDragOffset: 200);
    return Future.delayed(const Duration(seconds: 2), () {
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PullToRefreshNotification(
        key: _globalKey,
        color: Colors.blue,
        // pullBackOnRefresh: true,
        onRefresh: _onRefresh,
        armedDragUpCancel: false,
        maxDragOffset: 200,
        // refreshOffset: 100,
        child: NestedScrollView(
          controller: _scrollController,
          innerScrollPositionKeyBuilder: () {
            var index = 'Tab';
            index += _tabController.index.toString();
            return Key(index);
          },
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              PullToRefreshContainer(
                  (info) => buildPulltoRefreshImage(context, info)),
              // const SliverPadding(
              //   padding: EdgeInsets.only(top: 80),
              // ),
              SliverAppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                // foregroundColor: Colors.white,
                forceElevated: innerBoxIsScrolled,
                title: const Text(
                  '生产有限公司',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                centerTitle: false,
                pinned: true,
                // floating: true,
                elevation: 0,
                actions: const <Widget>[
                  Icon(Icons.more_horiz),
                ],
              ),
              SliverToBoxAdapter(
                child: _buildSearch(),
              ),
              SliverToBoxAdapter(child: _buildSwiper()),
              SliverToBoxAdapter(child: _buildGridView()),

              ///停留在顶部的TabBar
              _buildPersistentHeader(),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: _tabs
                .map((e) => NestedScrollViewInnerScrollPositionKeyWidget(
                      Key('${e['key'].toString()}'),
                      ShopHomeProductListPage(
                        keyword: e['title'].toString(),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  ///Search
  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: JDSearchBar(
        text: _searchText,
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
              itemCount: _recommendList.length,
              itemBuilder: (context, index) {
                ShopInfo shopInfo = _recommendList[index];
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
                tabs: _tabs.map((Map map) => Tab(text: map['title'])).toList(),
              ),
            )),
      );
}
