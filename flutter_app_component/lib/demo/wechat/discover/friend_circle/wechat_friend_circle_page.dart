import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/wechat/discover/friend_circle/wechat_friend_circle_navigator.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

import 'wechat_friend_circle_view_model.dart';

/// @author jd
class WechatFriendCirclePage extends StatefulWidget {
  @override
  _WechatFriendCirclePageState createState() => _WechatFriendCirclePageState();
}

class _WechatFriendCirclePageState extends State<WechatFriendCirclePage> {
  WechatFriendCircleNavigatorController _navigatorController =
      WechatFriendCircleNavigatorController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xff111111),
            child: ProviderWidget(
              model: WechatFriendCircleViewModel(),
              builder: (context, model) => NotificationListener(
                onNotification: (ScrollUpdateNotification scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                  return true;
                },
                child: CustomScrollView(
                  slivers: [
                    _buildUserInfo(),
                    _buildList(model),
                  ],
                ),
              ),
            ),
          ),
          WechatFriendCircleNavigator(
            controller: _navigatorController,
          ),
        ],
      ),
    );
  }

  void _onScroll(offset) {
    //修改导航alpha
    double alpha = offset / 100.0;
    alpha = min(1, alpha);
    alpha = max(0, alpha);
    _navigatorController.changeAlpha(alpha);
  }

  Widget _buildUserInfo() {
    return SliverToBoxAdapter(
      child: Container(
        height: 400,
        child: Stack(
          children: [
            Positioned.fill(
              top: -200,
              bottom: 20,
              child: Image.asset(
                JDAssetBundle.getImgPath('user_head'),
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'apple',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      JDAssetBundle.getImgPath('user_head_0'),
                      width: 100,
                      height: 100,
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

  Widget _buildList(WechatFriendCircleViewModel model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Map item = model.list[index];
          List imgs = item['imgs'];
          return Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    JDAssetBundle.getImgPath(item['icon']),
                    width: 60,
                    height: 60,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        item['msg'],
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 40,
                        ),
                        child: GridView.count(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          children: imgs
                              .map(
                                (e) => Image.asset(
                                  JDAssetBundle.getImgPath(e),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            item['time'],
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                              onPressed: () {}),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        childCount: model.list.length,
      ),
    );
  }
}
