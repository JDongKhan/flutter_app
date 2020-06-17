import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// @author jd

class JDDouyinPage extends StatefulWidget {
  @override
  _JDDouyinPageState createState() => _JDDouyinPageState();
}

class _JDDouyinPageState extends State<JDDouyinPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          _buildPage(),
          _buildTopMenu(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.black,
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
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return _buildPage1();
        });
  }

  Widget _buildPage1() {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildPlayer(),
            _buildRightMenu(),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    return Container(
      child: const Center(
        child: Text(
          '我是播放器',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

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

  Widget _buildRightMenu() {
    return Container(
      alignment: Alignment.centerRight,
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
    );
  }

  Widget _buildBottom() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '@JD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '广告收入、停车位收入、物业管理用房经营收入等都归业主所有，几乎每个小区都有，你拿到了吗？#苏州',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '@浙有正能量创作的原创',
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
}
