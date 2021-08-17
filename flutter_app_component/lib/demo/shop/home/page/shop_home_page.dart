import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/detail/shop_detail_page.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/jd_core.dart';

import 'shop_home_product_list_page.dart';

/// @author jd

class ShopHomePage extends StatefulWidget {
  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController _tabController;
  String _searchText;
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {
      'title': '推荐',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '投影仪',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '家用电器',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '服装',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '冰箱',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '其他',
      'key': GlobalKey<PrimaryScrollContainerState>(),
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
    //解决滚动问题
    _tabController.addListener(() {
      for (int i = 0; i < _tabs.length; i++) {
        GlobalKey<PrimaryScrollContainerState> key =
            _tabs[i]['key'] as GlobalKey<PrimaryScrollContainerState>;
        if (key != null && key.currentState != null) {
          key.currentState.onPageChange(_tabController.index == i);
        }
      }
    });

    super.initState();
  }

  Widget _refreshWidget({Widget child}) {
    const bool refreshEnable = true;
    if (refreshEnable) {
      return RefreshIndicator(
        notificationPredicate: (notification) {
          return true;
        },
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            return true;
          });
        },
        child: child,
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _refreshWidget(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

              ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
              sliver: SliverAppBar(
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
                  IconButton(
                    icon: Icon(Icons.business),
                  )
                ],
              ),
            ),
            // const SliverPadding(
            //   padding: EdgeInsets.only(top: 80),
            // ),
            const SliverToBoxAdapter(
              child: SafeArea(
                child: SizedBox(
                  height: 50,
                ),
              ),
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
              .map((e) => PrimaryScrollContainer(
                    e['key'] as GlobalKey<PrimaryScrollContainerState>,
                    ShopHomeProductListPage(
                      keyword: e['title'].toString(),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: JDSearchBar(
        text: _searchText,
        onTap: () {},
      ),
    );
  }

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

  @override
  bool get wantKeepAlive => true;
}
