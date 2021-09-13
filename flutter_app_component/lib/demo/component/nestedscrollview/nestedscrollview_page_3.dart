import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:jd_core/utils/jd_asset_bundle.dart';

class LoadMoreDemo extends StatefulWidget {
  @override
  _LoadMoreDemoState createState() => _LoadMoreDemoState();
}

class _LoadMoreDemoState extends State<LoadMoreDemo>
    with TickerProviderStateMixin {
  final List<Map<String, String>> _tabs = [
    {
      'title': '第一栏',
      'key': 'Tab0',
    },
    {
      'title': '第二栏',
      'key': 'Tab1',
    },
  ];
  TabController primaryTC;
  @override
  void initState() {
    primaryTC = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext c, bool f) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            title: const Text('NestedScrollView Page'),
            flexibleSpace: FlexibleSpaceBar(
              //centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: Image.asset(
                JDAssetBundle.getImgPath('bg_personal_real_name'),
                fit: BoxFit.fill,
              ),
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
          TabBar(
            controller: primaryTC,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            isScrollable: false,
            unselectedLabelColor: Colors.grey,
            tabs: _tabs
                .map(
                  (e) => Tab(
                    text: e['title'],
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: _tabs
                  .map(
                    (e) => TabViewItem(
                      Key(e['key']),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
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
            title: Text('List-$index'),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemCount: 100,
      ),
    );

    return NestedScrollViewInnerScrollPositionKeyWidget(widget.tabKey, child);
  }

  @override
  bool get wantKeepAlive => true;
}
