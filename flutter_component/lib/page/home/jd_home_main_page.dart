import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/models/home_model.dart';
import 'package:flutter_component/network/jd_request.dart';
import 'package:flutter_component/page/home/jd_home_searchbar_delegate.dart';
import 'package:flutter_component/style/jd_icons.dart';
import 'package:flutter_component/utils/jd_asset_bundle.dart';
import 'package:flutter_component/viewmodel/home_viewmodel.dart';
import 'package:flutter_component/widget/footerrefresh/jd_customfooter.dart';
import 'package:flutter_component/widget/loading/jd_loading.dart';
import 'package:flutter_component/widget/searchbar/jd_searchbar.dart';
import 'package:flutter_component/widget/sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// jd

class JDHomeMainPage extends StatefulWidget {
  @override
  State createState() => _JDHomeMainPageState();
}

class _JDHomeMainPageState extends State<JDHomeMainPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey tabKey = GlobalKey();

  String _searchText;
  double _appAlpha = 1;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _loadData() {
    //请求banner
    JDRequest.home().then(
        (dynamic value) => {context.read<HomeViewModel>().saveBanner(value)});
    //请求列表
    JDRequest.homeList().then(
        (dynamic value) => {context.read<HomeViewModel>().saveList(value)});
  }

  void _onRefresh() {
    _loadData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    //请求列表
    JDRequest.homeList().then((dynamic value) {
      if (value == null) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
        context.read<HomeViewModel>().loadMore(value);
      }
    });
  }

  Future<dynamic> _click() async {
    final String result =
        await showSearch(context: context, delegate: JDHomeSearchBarDelegate());
    setState(() {
      _searchText = result;
    });
  }

  void _onScroll(double offset) {
    double alpha = offset / 100;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appAlpha = alpha;
    });
//    print(alpha);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60 * (1 - _appAlpha)),
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (ScrollUpdateNotification scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                footer: JDCustomFooter(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: _buildScrollView(),
              ),
            ),
          ),
          _buildSearchBar(),
        ],
      ),
      floatingActionButton: _appAlpha != 1
          ? null
          : FloatingActionButton(
              child: Icon(Icons.keyboard_arrow_up),
              onPressed: () {
                _scrollController.animateTo(0.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildSearchBar() {
    return Container(
      transform: Matrix4.translationValues(0.0, -60.0 * _appAlpha, 0.0),
      child: JDSearchBar(
          text: _searchText,
          onTap: () {
            _click();
          }),
    );
  }

  Widget _buildSwiper() {
    final HomeModel homeModel = context.watch<HomeViewModel>().homeModel;
    if (homeModel?.banner == null || homeModel.banner.isEmpty) {
      return Container();
    }
    final List banner = homeModel?.banner;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Swiper(
        itemCount: banner.length,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red, color: Colors.green)),
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
              JDAssetBundle.getImgPath(banner[index]['image'].toString()));
        },
      ),
    );
  }

  Widget _buildScrollView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildSwiper(),
        ),
        _buildGridView(),
        _buildPersistentHeader(),
        _buildListView()
      ],
    );
  }

  Widget _buildGridView() {
    HomeModel homeModel = context.watch<HomeViewModel>().homeModel;
    if (homeModel?.menuGrid == null) {
      return SliverToBoxAdapter(child: Container());
    }
    var menuGrid = homeModel?.menuGrid;

    return SliverGrid.count(
      crossAxisCount: 4,
      children: List.generate(menuGrid.length, (index) {
        return Container(
          alignment: Alignment.center,
          child: Tab(
            icon: Icon(mappingForKey(menuGrid[index]['icon'].toString())),
            text: '${menuGrid[index]['title']}',
          ),
        );
      }),
    );
  }

  Widget _buildPersistentHeader() => SliverPersistentHeader(
        pinned: true,
        delegate: JDSliverPersistentHeaderDelegate(
            40,
            60,
            Container(
              color: Colors.cyanAccent,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '热门推荐',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      );

  Widget _buildListView() {
    HomeModelList homeModelList = context.watch<HomeViewModel>().homeModelList;
    if (homeModelList?.list == null) {
      return SliverToBoxAdapter(child: JDLoading(true));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Map itm = homeModelList.list[index];
          return Container(
            color: const Color(0xEEEEEEEE),
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.white,
              child: ListTile(
                  leading: Image.asset(JDAssetBundle.getImgPath(itm['icon'])),
                  title: Text(itm['title']),
                  subtitle: Text(
                    '￥${itm['price']}',
                    style: TextStyle(color: Colors.red),
                  )),
            ),
          );
        },
        childCount: homeModelList.list.length,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
