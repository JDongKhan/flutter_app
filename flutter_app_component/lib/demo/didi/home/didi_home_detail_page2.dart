import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class DidiHomeDetailPage extends StatefulWidget {
  @override
  _DidiHomeDetailPageState createState() => _DidiHomeDetailPageState();
}

class _DidiHomeDetailPageState extends State<DidiHomeDetailPage>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  final Color _backgoundColor = Colors.grey[100];
  AnimationController _animationController;
  Animation _animation;
  Animation _bottomAnimation;
  bool _startScroll = false;
  bool _userScrolling = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
        .animate(_animationController);

    _bottomAnimation = Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(_animationController);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: Stack(
          children: [
            _buildMapWidget(),
            SafeArea(bottom: false, child: _bottomSearchWidget()),
            _buildNavigatorWidget(),
          ],
        ),
      ),
    );
  }

  void _scrollEnd(offset) {
    if (!_userScrolling) return;
    print(offset);
    if (offset > 0 && offset < 200) {
      _scrollOverSearch();
    }
  }

  void _scrollOverSearch() {
    print('回到顶部-开始');
    Future.delayed(Duration(seconds: 0), () {
      print('回到顶部');
      _scrollController.animateTo(270,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  Widget _buildMapWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blue[100],
      child: Container(
        margin: const EdgeInsets.only(
          top: 150,
        ),
        alignment: Alignment.topCenter,
        child: const Text('SDK太大，假装我是地图'),
      ),
    );
  }

  Widget _buildNavigatorWidget() {
    return SlideTransition(
      position: _animation,
      child: Container(
        color: _backgoundColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: 44,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    JDButton(
                      action: () {
                        Navigator.of(context).pop();
                      },
                      imageDirection: AxisDirection.left,
                      text: Text(
                        '欢迎使用打车',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_none),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomSearchWidget() {
    return SlideTransition(
      position: _bottomAnimation,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 44),
        child: NotificationListener(
          onNotification: (notification) {
            // print(notification);
            if (notification is ScrollUpdateNotification) {
              if (notification.dragDetails == null) {
                //当没有数据的时候，说明手势放开了，
                _scrollEnd(notification.metrics.pixels);
                _userScrolling = false;
              } else {
                //判断是不是手势拖动的，有数据说明是手动拖动的
                _userScrolling = true;
              }
            } else if (notification is ScrollStartNotification) {
              _startScroll = true;
            } else if (notification is ScrollEndNotification) {
              _startScroll = false;
            } else if (notification is UserScrollNotification) {
              if (!_startScroll) {
                _scrollEnd(notification.metrics.pixels);
              }
            } else if (notification is DraggableScrollableNotification) {
              if (notification.extent > 0.9) {
                _scrollOverSearch();
              }
            }
          },
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              _scrollController = scrollController;
              return SingleChildScrollView(
                clipBehavior: Clip.none,
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.local_hospital_outlined),
                        Icon(Icons.my_location_outlined),
                      ],
                    ),
                    _searchWidget(),
                    _cardInfoWidget('我是菜单1'),
                    _cardInfoWidget('我是菜单2'),
                    _cardInfoWidget('我是菜单3'),
                    _cardInfoWidget('我是菜单4'),
                    _cardInfoWidget('我是菜单5'),
                    _cardInfoWidget('我是菜单6'),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: _backgoundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                '欢迎使用打车',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.album_rounded,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '玄武湖',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: _backgoundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.album_rounded,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '输入你的目的地',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      JDButton(
                        action: () {},
                        imageDirection: AxisDirection.left,
                        text: Text(
                          '预约',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        icon: Icon(
                          Icons.lock_clock,
                          color: Colors.grey,
                        ),
                      ),
                      JDButton(
                        action: () {},
                        imageDirection: AxisDirection.left,
                        text: Text(
                          '代叫',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        icon: Icon(
                          Icons.call,
                          color: Colors.grey,
                        ),
                      ),
                      JDButton(
                        action: () {},
                        imageDirection: AxisDirection.left,
                        text: Text(
                          '接送机',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        icon: Icon(
                          Icons.call_received,
                          color: Colors.grey,
                        ),
                      ),
                      JDButton(
                        action: () {},
                        imageDirection: AxisDirection.left,
                        text: Text(
                          '远途特价',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        icon: Icon(
                          Icons.money_off,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardInfoWidget(String title) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Container(
        color: Colors.grey[100],
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
