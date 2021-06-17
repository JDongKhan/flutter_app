import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/detail/jd_shop_detail_page.dart';
import 'package:flutter_app_component/demo/shop/model/jd_shop_info.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class JDShopHomePage extends StatefulWidget {
  @override
  _JDShopHomePageState createState() => _JDShopHomePageState();
}

class _JDShopHomePageState extends State<JDShopHomePage> {
  String _searchText;
  final List<String> _tabs = <String>[
    '推荐',
    '投影仪',
    '家用电器',
    '服装',
    '冰箱',
    '其他',
  ];

  final List<JDShopInfo> recommendList = [
    JDShopInfo(
      icon: JDAssetBundle.getImgPath('defalut_product'),
      shop_name: '洗发水',
      price: 18.80,
    ),
    JDShopInfo(
      icon: JDAssetBundle.getImgPath('defalut_product'),
      shop_name: '蛋糕',
      price: 8.80,
    ),
    JDShopInfo(
      icon: JDAssetBundle.getImgPath('defalut_product'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
    JDShopInfo(
      icon: JDAssetBundle.getImgPath('defalut_product'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
    JDShopInfo(
      icon: JDAssetBundle.getImgPath('defalut_product'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

              ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
              ///所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
              sliver: SliverAppBar(
                backgroundColor: Colors.blue,
                // foregroundColor: Colors.white,
                forceElevated: innerBoxIsScrolled,
                title: const Text(
                  '生产有限公司',
                  style: TextStyle(color: Colors.white),
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
            const SliverPadding(
              padding: EdgeInsets.only(top: 100),
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
          children: _tabs
              .map((e) => Builder(
                    // This Builder is needed to provide a BuildContext that is
                    // "inside" the NestedScrollView, so that
                    // sliverOverlapAbsorberHandleFor() can find the
                    // NestedScrollView.
                    builder: (BuildContext context) {
                      return _buildProductWidget();
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return JDSearchBar(
      text: _searchText,
      onTap: () {},
    );
  }

  Widget _buildSwiper() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Swiper(
        itemCount: 5,
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red, color: Colors.green)),
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(JDAssetBundle.getImgPath('bg_personal_real_name'));
        },
      ),
    );
  }

  Widget _buildGridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
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
                  childAspectRatio: 1.0 //显示区域宽高相等
                  ),
              itemCount: recommendList.length,
              itemBuilder: (context, index) {
                JDShopInfo shopInfo = recommendList[index];
                //如果显示到最后一个并且Icon总数小于200时继续获取数据
                return _buildGirdItem(shopInfo);
              }),
        ),
      ],
    );
  }

  Widget _buildGirdItem(JDShopInfo shopInfo) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return JDShopDetailPage(shopInfo);
        }));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              child: Center(
                child: Image.asset(shopInfo.icon),
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
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  // These are the widgets to put in each tab in the tab bar.
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            )),
      );

  Widget _buildProductWidget() {
    return Container(
      color: Colors.grey[100],
      child: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(1.0),
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        mainAxisSpacing: 10.0,
        itemCount: recommendList.length * 2,
        crossAxisSpacing: 10.0,
        itemBuilder: (BuildContext context, int index) {
          JDShopInfo shopInfo = recommendList[index % recommendList.length];
          return _buildGirdItem(shopInfo);
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      ),
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
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Image.asset(
                JDAssetBundle.getImgPath('ali_connors'),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 10,
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
}
