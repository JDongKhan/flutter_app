import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/douyin/home/page/douyin_home_recommend_page.dart';
import 'package:jd_core/widget/searchbar/jd_searchbar.dart';

/// @author jd

class DouyinFriendPage extends StatefulWidget {
  @override
  _DouyinFriendPageState createState() => _DouyinFriendPageState();
}

class _DouyinFriendPageState extends State<DouyinFriendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Positioned.fill(
        child: DouyinHomeRecommendPage(
          source: 'friend',
        ),
      ),
      Positioned(left: 0, top: 0, right: 0, child: _buildSearchWidget()),
    ]);
  }

  Widget _buildSearchWidget() {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: JDSearchBar(
              hintText: '朋友',
              radius: 0,
              color: const Color(0x55ffffff),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
