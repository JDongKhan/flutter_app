import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/component/pop/pop_route.dart';
import 'package:flutter_app_component/demo/wechat/discover/friend_circle/widget/wechat_friend_circle_navigator.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

import '../vm/wechat_friend_circle_view_model.dart';

/// @author jd
class WechatFriendCirclePage extends StatefulWidget {
  @override
  _WechatFriendCirclePageState createState() => _WechatFriendCirclePageState();
}

class _WechatFriendCirclePageState extends State<WechatFriendCirclePage> {
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  final WechatFriendCircleNavigatorController _navigatorController =
      WechatFriendCircleNavigatorController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: -40,
            child: Container(
              color: const Color(0xff111111),
              child: ProviderWidget(
                model: WechatFriendCircleViewModel(),
                builder: (context, model) => NotificationListener(
                  onNotification:
                      (ScrollUpdateNotification scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return true;
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    slivers: [
                      _buildUserInfo(),
                      _buildList(model),
                    ],
                  ),
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

  void _onScroll(double offset) {
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
              top: 0,
              left: 0,
              right: 0,
              bottom: 20,
              child: Image.asset(
                JDAssetBundle.getImgPath('login_background'),
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'apple',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
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
        (BuildContext context, int index) {
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
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        item['msg'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
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
                          physics: const NeverScrollableScrollPhysics(),
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
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Spacer(),
                          Builder(
                            builder: (BuildContext context) {
                              return IconButton(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _showCommentWidget(context);
                                  });
                            },
                          ),
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

  ///弹出退出按钮
  ///点击退出调用onClick
  void _showCommentWidget(BuildContext context) {
    showPopMenu(
      context: context,
      alignment: Alignment.topLeft,
      child: _buildCommentWidget(),
    );
  }

  Widget _buildCommentWidget() {
    return Container(
      width: 140,
      height: 40,
      color: Colors.blue,
      child: Row(
        children: [
          JDButton(
            action: () {},
            text: const Text('赞'),
            icon: const Icon(Icons.favorite),
            imageDirection: AxisDirection.left,
          ),
          const VerticalDivider(),
          JDButton(
            action: () {},
            text: const Text('评论'),
            icon: const Icon(Icons.comment_bank_sharp),
            imageDirection: AxisDirection.left,
          ),
        ],
      ),
    );
  }
}
