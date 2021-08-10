import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/widget/sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';

/// @author jd

class CustomScrollViewPage2 extends StatefulWidget {
  @override
  _CustomScrollViewPage2State createState() => _CustomScrollViewPage2State();
}

class _CustomScrollViewPage2State extends State<CustomScrollViewPage2> {
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    {
      'title': '热点',
    },
    {
      'title': '地方',
    },
    {
      'title': '直播',
    },
    {
      'title': '社会',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: CustomScrollView(
          slivers: <Widget>[
            _buildStyle0AppBar(),
//            SliverPersistentHeader(
//              delegate: SliverCustomHeaderDelegate(
//                collapsedHeight: 50,
//                expandedHeight: 56,
//                paddingTop: 20,
//                title: '我的',
//              ),
////              pinned: true,
//            ),
            SliverPersistentHeader(
              delegate: JDSliverPersistentHeaderDelegate(60, 80, _tabBar()),
              pinned: true,
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: _tabs.map((e) => _buildContent(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyle0AppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      centerTitle: true,
      title: const Text(
        '我的',
        style: TextStyle(color: Colors.white),
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
          ],
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

  Widget _buildContent(Map item) {
    return Container(
      color: Colors.grey[100],
      key: PageStorageKey<String>(item['title']),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.separated(
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
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  const SliverCustomHeaderDelegate(
      {this.collapsedHeight,
      this.expandedHeight,
      this.paddingTop,
      this.coverImgUrl,
      this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          coverImgUrl == null
              ? Container()
              : Container(
                  child: Image.network(coverImgUrl, fit: BoxFit.cover),
                ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: makeStickyHeaderTextColor(shrinkOffset, true),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: makeStickyHeaderTextColor(
                            shrinkOffset,
                            false,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color makeStickyHeaderBgColor(double shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(double shrinkOffset, bool isIcon) {
    if (shrinkOffset < 50) {
      return isIcon ? Colors.blue : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  double get maxExtent => collapsedHeight + paddingTop;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
