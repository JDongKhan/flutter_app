import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter/material.dart';
import 'package:flutter_component/utils/jd_asset_bundle.dart';

/// @author jd

class JDDouyinPeopleDetailPage extends StatefulWidget {
  @override
  _JDDouyinPeopleDetailPageState createState() =>
      _JDDouyinPeopleDetailPageState();
}

class _JDDouyinPeopleDetailPageState extends State<JDDouyinPeopleDetailPage>
    with TickerProviderStateMixin {
  TabController primaryTC;
  ScrollController _scrollController = ScrollController();

  double appAlpha = 0;

  final GlobalKey<NestedScrollViewState> _key =
      GlobalKey<NestedScrollViewState>();

  @override
  void initState() {
    primaryTC = TabController(length: 2, vsync: this);
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.positions.elementAt(0).pixels;
      setState(() {
        appAlpha = offset / 200;
        print(appAlpha);
      });
    });
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          _buildScaffoldBody(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.black,
    );
  }

  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return extended.NestedScrollView(
      key: _key,
      controller: _scrollController,
      headerSliverBuilder: (BuildContext c, bool f) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
              )
            ],
            title: appAlpha < 0.5
                ? Container()
                : Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '商业小纸条',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          width: 80,
                          margin: EdgeInsets.only(left: 10),
                          child: FlatButton(
                            color: Colors.red,
                            child: Text(
                              '关注',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
            flexibleSpace: FlexibleSpaceBar(
              //centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: _buildHead(),
            ),
          ),
        ];
      },
      //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
      innerScrollPositionKeyBuilder: () {
        String index = 'Tab';

        index += primaryTC.index.toString();

        return Key(index);
      },
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: TabBar(
              controller: primaryTC,
              labelColor: Colors.grey[350],
              indicatorColor: Colors.lightGreen,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.0,
              isScrollable: false,
              unselectedLabelColor: Colors.white,
              tabs: const <Tab>[
                Tab(
                  text: '作品554',
                ),
                Tab(text: '喜欢112'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: const <Widget>[
                TabViewItem(Key('Tab0')),
                TabViewItem(Key('Tab1')),
              ],
            ),
          )
        ],
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
                      Image.asset(
                        JDAssetBundle.getImgPath('head'),
                        fit: BoxFit.fill,
                        width: 60,
                        height: 60,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: FlatButton(
                            color: Colors.blue,
                            splashColor: Colors.blue,
                            colorBrightness: Brightness.dark,
                            child: const Text('+关注'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '青春湖北',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '抖音号:dy8x6hav5p8h',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
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
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '是谁这么优秀想要关注团团',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
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
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.tabKey);
  final Key tabKey;
  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Widget child = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                'List-$index',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: Colors.white,
              ),
          itemCount: 100),
    );

    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
        widget.tabKey, child);
  }

  @override
  bool get wantKeepAlive => true;
}
