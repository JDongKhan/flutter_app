import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

import 'didi_home_detail_page.dart';

/// @author jd

class DidiHomePage extends StatefulWidget {
  @override
  _DidiHomePageState createState() => _DidiHomePageState();
}

class _DidiHomePageState extends State<DidiHomePage> {
  final Color _backgoundColor = Colors.grey[100];
  bool _hasPush = false;
  double _mapOffset = 0;
  double _menuOffset = 200;
  List<Map<String, dynamic>> _menuList = [
    {
      'title': '打车',
      'icon': 'user_head_0',
    },
    {
      'title': '橙心优选',
      'icon': 'user_head_1',
    },
    {
      'title': '青桔骑行',
      'icon': 'user_head_2',
    },
    {
      'title': '运货/搬家',
      'icon': 'user_head_3',
    },
    {
      'title': '加油/充电',
      'icon': 'user_head_4',
    },
    {
      'title': '7天种水果',
      'icon': 'user_head_0',
    },
    {
      'title': '特价拼车',
      'icon': 'user_head_1',
    },
    {
      'title': '专车',
      'icon': 'user_head_2',
    },
    {
      'title': '顺风车',
      'icon': 'user_head_3',
    },
    {
      'title': '公交地铁',
      'icon': 'user_head_4',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backgoundColor,
      child: Stack(
        children: [
          _buildMapWidget(),
          SafeArea(
            child: Container(
              transform: Matrix4.translationValues(0.0, _menuOffset, 0.0),
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: _buildScrollWidget(),
            ),
          ),
          _buildNavigatorWidget(),
        ],
      ),
    );
  }

  Widget _buildNavigatorWidget() {
    return Container(
      color: _backgoundColor,
      child: SafeArea(
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
                    action: () {},
                    imageDirection: AxisDirection.left,
                    text: Text(
                      '南京',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.cloud_outlined),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_none),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.qr_code_scanner_outlined),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapWidget() {
    return Container(
      transform: Matrix4.translationValues(0.0, _mapOffset, 0.0),
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      color: Colors.orange,
      height: 500,
      child: Container(
        margin: const EdgeInsets.only(top: 150, left: 150),
        child: Text('假装我是地图'),
      ),
    );
  }

  void _scroll(offset) {
    //处理map偏移
    if (offset >= 0) {
      _mapOffset = -offset;
      _menuOffset = 200 - offset;
      if (offset > 200) {
        _mapOffset = -200;
        _menuOffset = 0;
      }
      setState(() {});
    } else {
      _mapOffset = 0;
    }
    print(offset);

    //如果下拉超过150则显示详情
    if (offset < -150 && !_hasPush) {
      print('我跳转到详情');
      Navigator.of(context).push(JDNoAnimRouter(child: DidiHomeDetailPage()));
      _hasPush = true;
      Future.delayed(Duration(seconds: 1), () {
        _hasPush = false;
      });
    }
  }

  Widget _buildScrollWidget() {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        _scroll(notification.metrics.pixels);
      },
      child: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          _buildSearchWidget(),
          _buildMenuWidget(),
          _buildBusWidget(),
          _buildBicycleWidget(),
        ],
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SliverToBoxAdapter(
      child: Container(
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
            Container(
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 20, top: 10),
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
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuWidget() {
    return SliverToBoxAdapter(
      child: Container(
        color: _backgoundColor,
        height: 200,
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: _menuList.length,
            itemBuilder: (context, index) {
              Map item = _menuList[index];
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        JDAssetBundle.getImgPath(item['icon']),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          item['title'],
                          maxLines: 1,
                          style: TextStyle(fontSize: 14),
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildBusWidget() {
    return SliverToBoxAdapter(
      child: Container(
        color: _backgoundColor,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '公交',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Container(
                    height: 210,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: const Text(
                              '公交多久到，一查就知道',
                              style: TextStyle(fontSize: 12),
                            )),
                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: const Text(
                            '实时公交',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        TextButton(
                          onPressed: () {},
                          child: Text('查看更多'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        color: Colors.grey[100],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                '绿色交通 低碳出行',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                '地铁图',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                '定制路线 路况早知道',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                '路线查询',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        color: Colors.grey[100],
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBicycleWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '骑行',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                Container(
                  height: 210,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: const Text(
                            '公交多久到，一查就知道',
                            style: TextStyle(fontSize: 12),
                          )),
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: const Text(
                          '实时公交',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      TextButton(
                        onPressed: () {},
                        child: Text('查看更多'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      margin: const EdgeInsets.only(left: 10, bottom: 10),
                      color: Colors.grey[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              '绿色交通 低碳出行',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              '地铁图',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              '定制路线 路况早知道',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              '路线查询',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.grey[100],
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
