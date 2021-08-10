import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/demo/douyin/comment_widget.dart';
import 'package:flutter_app_component/demo/douyin/like_gesture_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:marquee/marquee.dart';

import 'doiyin_people_detail_page.dart';
import 'douyin_player.dart';
import 'vinyl_disk.dart';

/// @author jd

class DouYinHomePage extends StatefulWidget {
  @override
  _DouYinHomePageState createState() => _DouYinHomePageState();
}

class _DouYinHomePageState extends State<DouYinHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Map<String, dynamic>> _list = [
    {
      'video_url': 'assets/videos/video_1.mp4',
      'author_name': 'JD_1',
      'content': '广告收入、停车位收入、物业管理用房经营收入等都归业主所有，几乎每个小区都有，你拿到了吗？#苏州',
      'source': '@浙有正能量创作的原创',
    },
    {
      'video_url': 'assets/videos/video_2.mp4',
      'author_name': 'JD_2',
      'content': '广告收入、停车位收入、物业管理用房经营收入等都归业主所有，几乎每个小区都有，你拿到了吗？#苏州',
      'source': '@浙有正能量创作的原创',
    },
    {
      'video_url': 'assets/videos/video_3.mp4',
      'author_name': 'JD_3',
      'content': '广告收入、停车位收入、物业管理用房经营收入等都归业主所有，几乎每个小区都有，你拿到了吗？#苏州',
      'source': '@浙有正能量创作的原创',
    },
    {
      'video_url': 'assets/videos/video_4.mp4',
      'author_name': 'JD_4',
      'content': '广告收入、停车位收入、物业管理用房经营收入等都归业主所有，几乎每个小区都有，你拿到了吗？#苏州',
      'source': '@浙有正能量创作的原创',
    },
    {
      'video_url': 'assets/videos/video_5.mp4',
      'author_name': 'JD_5',
      'content': '广告收入、停车位收入、物业管理用房经营收入等都归业主所有，几乎每个小区都有，你拿到了吗？#苏州',
      'source': '@浙有正能量创作的原创',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildBackground(),
            LikeGestureWidget(
              onAddFavorite: () {
                debugPrint('我在双击');
              },
              onSingleTap: () {
                debugPrint('我在单击');
              },
              child: _buildPage(),
            ),
            _buildTopMenu(),
          ],
        ),
      ),
    );
  }

  /******  背景 ********/
  Widget _buildBackground() {
    return Container(
      color: Colors.black,
    );
  }

  @override
  void deactivate() {
    debugPrint('deactivate');
    super.deactivate();
  }
  /******  顶部菜单 ********/

  Widget _buildTopMenu() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 80,
              ),
              _buildTabbar(),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabbar() {
    return Container(
      width: 200,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        tabs: const <Widget>[
          Tab(
            child: Text(
              '关注',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Tab(
            child: Text(
              '推荐',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Container(
          color: Colors.red,
          child: const Center(
            child: Text(
              '需要登录',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        _buildPlayPage(),
      ],
    );
  }

  Widget _buildPlayPage() {
    return Swiper(
        scrollDirection: Axis.vertical,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          Map item = _list[index];
          return _buildPage1(item);
        });
  }

  Widget _buildPage1(Map item) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          _buildPlayer(item),
          _buildRightMenu(item),
          _buildBottom(item),
        ],
      ),
    );
  }

  Widget _buildPlayer(Map item) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: DouyinPlayer(
        url: item['video_url'],
      ),
    );
  }

  Widget _buildRightMenu(Map item) {
    return Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          debugPrint('right');
        },
        child: Container(
          width: 80,
          height: 300,
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  debugPrint('add');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  debugPrint('favorite');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              IconButton(
                icon: Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                onPressed: () {
                  debugPrint('comment');
                  _commentAction();
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {
                  debugPrint('share');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom(Map item) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 64),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          JDNavigationUtil.push(DouyinPeopleDetailPage());
                        },
                        child: Text(
                          item['author_name'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        item['content'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 30,
                      // color: Colors.red,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item['source'].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              margin: const EdgeInsets.only(left: 10),
                              child: Marquee(
                                text: '隐形的翅膀-张韶涵',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 50,
              alignment: Alignment.bottomRight,
              child: VinylDisk(JDAssetBundle.getImgPath('user_head_0')),
            ),
          ],
        ),
      ),
    );
  }

  void _commentAction() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CommentWidget();
        });
  }
}
