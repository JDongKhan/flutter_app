import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/style/jd_icons.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/utils/jd_screen_utils.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:jd_core/widget/Text/jd_expandable_text.dart';
import 'package:jd_core/widget/footerrefresh/jd_customfooter.dart';
import 'package:jd_core/widget/loading/jd_loading.dart';
import 'package:jd_core/widget/searchbar/jd_searchbar.dart';
import 'package:jd_core/widget/sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';
import 'package:jd_home/models/home_model.dart';
import 'package:jd_home/pages/home/detail/jd_home_Info_detail_page.dart';
import 'package:jd_home/pages/home/detail/jd_home_main_detail_page.dart';
import 'package:jd_home/pages/home/jd_home_searchbar_delegate.dart';
import 'package:jd_home/pages/home/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'viewmodel/home_list_view_model.dart';

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

  HomeListViewModel _listViewModel = HomeListViewModel();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() {
    _listViewModel.refresh();
  }

  void _onLoading() {
    _listViewModel.loadMore();
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
    //TODO 下面的方法会导致build重复调用，可以优化
    if (alpha != _appAlpha) {
      setState(() {
        _appAlpha = alpha;
      });
    }
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
              child: Provider2Widget<HomeViewModel, HomeListViewModel>(
                model1: HomeViewModel(),
                model2: _listViewModel,
                onModelReady: (model1, model2) {
                  model1.initData();
                  model2.initData();
                },
                builder: (BuildContext context) {
                  return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    footer: JDCustomFooter(),
                    controller: _listViewModel.refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: _buildScrollView(context),
                  );
                },
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
                // JDNavigationUtil.push(JDHomeDemo());
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

  Widget _buildSwiper(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();
    final HomeModel homeModel = viewModel.data;
    if (homeModel?.banner == null || homeModel.banner.isEmpty) {
      return Container();
    }
    final List banner = homeModel?.banner;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Swiper(
        itemCount: banner.length,
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red, color: Colors.green)),
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
              JDAssetBundle.getImgPath(banner[index]['image'].toString()));
        },
      ),
    );
  }

  Widget _buildScrollView(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _buildSwiper(context),
        ),

        _buildGridView(context),
        _buildPersistentHeader('热门推荐'),
        // SliverLayoutBuilder(
        //   builder: (BuildContext context, SliverConstraints constraints) {
        //     return  _buildListView(context);
        //   },
        // ),
        _buildListView(context)
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();
    HomeModel homeModel = viewModel.data;
    var menuGrid = homeModel?.menuGrid;
    if (viewModel.busy || menuGrid == null) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverGrid.count(
      crossAxisCount: 4,
      children: List.generate(menuGrid.length, (index) {
        return InkWell(
          onTap: () {
            JDNavigationUtil.push(JDHomeMainDetailPage());
          },
          child: Container(
            alignment: Alignment.center,
            child: Tab(
              icon: Icon(mappingForKey(menuGrid[index]['icon'].toString())),
              text: '${menuGrid[index]['title']}',
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPersistentHeader(String title) => SliverPersistentHeader(
        pinned: true,
        delegate: JDSliverPersistentHeaderDelegate(
            40,
            60,
            Container(
              color: Colors.cyanAccent,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      );

  Widget _buildListView(BuildContext context) {
    HomeListViewModel homeModelList = context.watch<HomeListViewModel>();
    if (homeModelList.busy) {
      return const SliverToBoxAdapter(child: JDLoading(loading: true));
    }
    if (homeModelList.error) {
      return const SliverFillRemaining(
        child: JDLoading(
          error: true,
          errorMsg: '网络连接失败',
        ),
      );
    }

    if (homeModelList.empty) {
      return const SliverFillRemaining(
        child: JDLoading(
          error: true,
          errorMsg: '暂无数据',
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Map itm = homeModelList.list[index];
          if (index == 2) {
            return _buildTyle2Cell(itm);
          }
          return _buildTyle1Cell(itm);
        },
        childCount: homeModelList.list.length,
      ),
    );
  }

  Widget _buildTyle1Cell(Map itm) {
    return InkWell(
      onTap: () {
        JDNavigationUtil.push(JDHomeInfoDetailPage(
          userInfo: itm,
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //顶部
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    JDAssetBundle.getImgPath(itm['icon']),
                    width: 60,
                    height: 60,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itm['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            itm['type'],
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('立即咨询'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                )
              ],
            ),
            //content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(itm['content']),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 40,
              ),
              child: GridView.count(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                ),
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: ['user_head_1', 'user_head_2', 'user_head_3']
                    .map(
                      (e) => Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          JDAssetBundle.getImgPath(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              child: Text(
                "${itm['time']} 发布",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildTyle2Cell(Map itm) {
    return Container(
      margin: EdgeInsets.only(
          top: jd_getWidth(10), bottom: jd_getHeight(11), left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: const JDExpandableText(
        '我要测试是十四师是死是活我要死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活我要测试是十四师是死是活',
        maxLines: 2,
        style: TextStyle(fontSize: 10, color: Colors.black),
        markerStyle: TextStyle(fontSize: 14, color: Colors.orange),
        atName: 'JD',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
