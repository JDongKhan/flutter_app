import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/shop/home/vm/custom_bouncing_scroll_physics.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @author jd
class ShopHomeProductListPage extends StatefulWidget {
  const ShopHomeProductListPage({Key key, this.keyword, this.parsentController})
      : super(key: key);
  final String keyword;
  final ScrollController parsentController;
  @override
  _ShopHomeProductListPageState createState() =>
      _ShopHomeProductListPageState();
}

class _ShopHomeProductListPageState extends State<ShopHomeProductListPage>
    with AutomaticKeepAliveClientMixin {
  final List<ShopInfo> _recommendList = [];
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() {
    _recommendList.addAll([
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: _refreshWidget(
        child: StaggeredGridView.countBuilder(
          physics: const CustomBouncingScrollPhysics(),
          padding: const EdgeInsets.all(1.0),
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          itemCount: _recommendList.length * 2,
          crossAxisSpacing: 10.0,
          itemBuilder: (BuildContext context, int index) {
            return _buildProductItem(index);
          },
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        ),
      ),
    );
  }

  Widget _refreshWidget({Widget child}) {
    const bool refreshEnable = true;
    if (refreshEnable) {
      return SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        footer: JDCustomFooter(),
        controller: _refreshController,
        onLoading: _onLoading,
        child: child,
      );
    }
    return child;
  }

  void _onLoading() {
    // _refreshController.refreshCompleted();
    _addMoreData();
    _refreshController.loadComplete();
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
              margin: const EdgeInsets.all(10),
              child: Image.asset(
                JDAssetBundle.getImgPath('shop_${index % 5}'),
                height: index == 0 ? 100 : 120,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                child: const Text(
                  '商品名称',
                  overflow: TextOverflow.ellipsis,
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

  void _addMoreData() {
    _recommendList.addAll([
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
    ]);
    setState(() {});
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(covariant ShopHomeProductListPage oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  bool get wantKeepAlive => true;
}
