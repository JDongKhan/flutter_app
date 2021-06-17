import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/detail/jd_shop_detail_page.dart';
import 'package:flutter_app_component/demo/shop/model/jd_shop_info.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd
class JDShopSearchPage extends StatefulWidget {
  @override
  _JDShopSearchPageState createState() => _JDShopSearchPageState();
}

class _JDShopSearchPageState extends State<JDShopSearchPage> {
  List<JDShopInfo> list = [];

  bool showGrid = false;

  @override
  void initState() {
    list = List.generate(
      50,
      (index) => JDShopInfo(
        icon: JDAssetBundle.getImgPath('defalut_product'),
        shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
        price: 48.80,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          color: Colors.red,
        ),
      ),
      appBar: AppBar(
        title: _buildSearch(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.category),
              onPressed: () {
                setState(() {
                  showGrid = !showGrid;
                });
              })
        ],
      ),
      body: Column(
        children: [
          _buildCondition(),
          showGrid
              ? Expanded(child: _buildGridWidget())
              : Expanded(child: _buildListWidget()),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return JDSearchBar();
  }

  Widget _buildCondition() {
    return Container(
      height: 40,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          Text('综合'),
          SizedBox(
            width: 10,
          ),
          JDButton(
            icon: Icon(Icons.sort),
            text: Text('价格'),
            imageDirection: AxisDirection.right,
            backgroundColor: Colors.transparent,
          ),
          Expanded(child: Container()),
          Builder(
            builder: (context) {
              return JDButton(
                action: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.filter_list),
                text: Text('筛选'),
                imageDirection: AxisDirection.right,
                backgroundColor: Colors.transparent,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListWidget() {
    return ListView.separated(
        itemBuilder: (c, idx) {
          JDShopInfo shopInfo = list[idx];
          return _buildListItem(shopInfo);
        },
        separatorBuilder: (c, idx) {
          return Divider(
            height: 1,
          );
        },
        itemCount: list.length);
  }

  Widget _buildListItem(JDShopInfo shopInfo) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _pushNext(shopInfo);
      },
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset(shopInfo.icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopInfo.shop_name),
                SizedBox(
                  height: 10,
                ),
                Text(shopInfo.price.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridWidget() {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //每行三列
            mainAxisSpacing: 15,
            childAspectRatio: 1.0 //显示区域宽高相等
            ),
        itemBuilder: (c, idx) {
          JDShopInfo shopInfo = list[idx];
          return _buildGirdItem(shopInfo);
        },
      ),
    );
  }

  Widget _buildGirdItem(JDShopInfo shopInfo) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _pushNext(shopInfo);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset(shopInfo.icon),
              ),
            ),
            Text(shopInfo.shop_name),
            SizedBox(
              height: 10,
            ),
            Text(shopInfo.price.toString()),
          ],
        ),
      ),
    );
  }

  void _pushNext(JDShopInfo shopInfo) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return JDShopDetailPage(shopInfo);
    }));
  }
}
