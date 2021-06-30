import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/douyin/comment_widget.dart';
import 'package:flutter_app_component/demo/douyin/like_gesture_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import 'jd_doiyin_people_detail_page.dart';
import 'jd_douyin_player.dart';

/// @author jd

class JDDouYinHomePage extends StatefulWidget {
  @override
  _JDDouYinHomePageState createState() => _JDDouYinHomePageState();
}

class _JDDouYinHomePageState extends State<JDDouYinHomePage>
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          LikeGestureWidget(
            onAddFavorite: () {
              print('我在双击');
            },
            onSingleTap: () {
              print('我在单击');
            },
            child: _buildPage(),
          ),
          _buildTopMenu(),
        ],
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
    print('deactivate');
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
      child: JDDouyinPlayer(
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
          print('right');
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
                  print('add');
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
                  print('favorite');
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
                  print('comment');
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
                  print('share');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom(Map item) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 64),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        JDNavigationUtil.push(JDDouyinPeopleDetailPage());
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
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      item['source'].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 50,
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                ),
              ),
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
