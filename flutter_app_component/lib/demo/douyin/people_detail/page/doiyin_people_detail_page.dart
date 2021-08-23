// import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
//     as extended;
import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/shop/home/vm/custom_bouncing_scroll_physics.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/widget//sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';

/// @author jd

class DouyinPeopleDetailPage extends StatefulWidget {
  @override
  _DouyinPeopleDetailPageState createState() => _DouyinPeopleDetailPageState();
}

class _DouyinPeopleDetailPageState extends State<DouyinPeopleDetailPage>
    with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  double appAlpha = 0;

  final GlobalKey<NestedScrollViewState> _key =
      GlobalKey<NestedScrollViewState>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.positions.elementAt(0).pixels;
      setState(() {
        appAlpha = offset / 200;
        debugPrint(appAlpha.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _buildScaffoldBody(),
      ),
    );
  }

  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return NestedScrollView(
      key: _key,
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool f) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              pinned: true,
              expandedHeight: 300.0,
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor:
                  appAlpha < 0.5 ? Colors.transparent : Colors.black,
              actions: <Widget>[
                _buildMoreAction(),
              ],
              title: _buildAppBar(),
              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: _buildHead(),
              ),
            ),
          ),
          _buildPersistentHeader(),
        ];
      },
      body: const TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          TabViewItem(PageStorageKey('Tab1')),
          TabViewItem(PageStorageKey('Tab2')),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return appAlpha < 0.5
        ? Container()
        : Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Text(
                  '商业小纸条',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  width: 80,
                  margin: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      '关注',
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildMoreAction() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHead() {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            JDAssetBundle.getImgPath('login_background'),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              top: 44,
            ),
            child: Container(
              color: Colors.black,
              margin: const EdgeInsets.only(
                top: 40,
              ),
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          JDAssetBundle.getImgPath('user_head_0'),
                          fit: BoxFit.fill,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 40, right: 40),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              shadowColor: Colors.blue[100],
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text('+关注'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '青春湖北',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '抖音号:dy8x6hav5p8h',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.map,
                          color: Colors.blue,
                        ),
                        Text(
                          'JD工作室',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '是谁这么优秀想要关注团团',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: const <Widget>[
                        Text(
                          '7125.0w获赞   ',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '148关注   ',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '235.9w粉丝',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPersistentHeader() => SliverPersistentHeader(
        pinned: true,
        delegate: JDSliverPersistentHeaderDelegate(
            40,
            60,
            Container(
              color: Colors.black,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: TabBar(
                  // controller: primaryTC,
                  labelColor: Colors.grey[350],
                  indicatorColor: Colors.lightGreen,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.0,
                  isScrollable: false,
                  unselectedLabelColor: Colors.white,
                  tabs: const <Tab>[
                    Tab(
                      text: '作品(554)',
                    ),
                    Tab(text: '喜欢(112)'),
                  ],
                ),
              ),
            )),
      );
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.tabKey);
  final PageStorageKey tabKey;
  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem> {
  final List<String> _list = [
    'video_0',
    'video_1',
    'video_2',
    'video_3',
    'video_4',
    'video_5',
    'video_6',
    'video_7',
    'video_8',
    'video_9',
    'video_10',
    'video_11',
    'video_12',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.tabKey,
      margin: EdgeInsets.only(
        top: kToolbarHeight + MediaQuery.of(context).padding.top,
      ),
      child: StaggeredGridView.countBuilder(
        physics: const CustomBouncingScrollPhysics(),
        padding: const EdgeInsets.all(2.0),
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        itemCount: _list.length * 2,
        crossAxisSpacing: 2.0,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(index);
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Image.asset(
      JDAssetBundle.getImgPath(_list[index % _list.length]),
    );
  }
}
