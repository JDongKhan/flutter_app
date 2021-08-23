import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/douyin/home/widget/comment_widget.dart';
import 'package:flutter_app_component/demo/douyin/people_detail/page/doiyin_people_detail_page.dart';
import 'package:flutter_app_component/demo/douyin/player/douyin_player.dart';
import 'package:flutter_app_component/demo/douyin/player/like_gesture_widget.dart';
import 'package:flutter_app_component/demo/douyin/player/vinyl_disk.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:marquee/marquee.dart';

/// @author jd
/// 推荐

class DouyinHomeRecommendPage extends StatefulWidget {
  const DouyinHomeRecommendPage({this.source});
  final String source; //来源
  @override
  _DouyinHomeRecommendPageState createState() =>
      _DouyinHomeRecommendPageState();
}

class _DouyinHomeRecommendPageState extends State<DouyinHomeRecommendPage>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _list = [
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

  int _currentIndex = 0;
  List<DouyinPlayerController> _pageControllerList;

  @override
  void initState() {
    _pageControllerList = List.generate(
      _list.length,
      (index) => DouyinPlayerController(index == 0),
    ).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LikeGestureWidget(
      onAddFavorite: () {
        debugPrint('我在双击');
      },
      onSingleTap: () {
        debugPrint('我在单击');
      },
      child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _list.length,
          controller: _pageController,
          // allowImplicitScrolling: true,
          // dragStartBehavior: DragStartBehavior.down,
          onPageChanged: (int index) {
            print('index:$index');
            DouyinPlayerController preController =
                _pageControllerList[_currentIndex];
            DouyinPlayerController currentController =
                _pageControllerList[index];
            preController.pause();
            currentController.play();
            _currentIndex = index;
          },
          // layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            return _buildPage(index);
          }),
    );
  }

  ///页面布局
  Widget _buildPage(int index) {
    Map item = _list[index];
    DouyinPlayerController douyinPlayerController = _pageControllerList[index];
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          _buildPlayer(item, douyinPlayerController),
          _buildRightMenu(item),
          _buildBottom(item),
        ],
      ),
    );
  }

  ///播放器布局
  Widget _buildPlayer(Map item, DouyinPlayerController douyinPlayerController) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: DouyinPlayer(
        douyinPlayerController: douyinPlayerController,
        source: widget.source,
        url: item['video_url'],
      ),
    );
  }

  ///播放器上面的右侧菜单
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
                icon: const Icon(
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
                icon: const Icon(
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
                icon: const Icon(
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
                icon: const Icon(
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

  ///播放器上面的底部信息布局
  Widget _buildBottom(Map item) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        // margin: const EdgeInsets.only(bottom: 0),
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
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        item['content'].toString(),
                        style: const TextStyle(color: Colors.white),
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
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Container(
                              height: 25,
                              margin: const EdgeInsets.only(left: 10),
                              child: Marquee(
                                text: '隐形的翅膀-张韶涵',
                                style: const TextStyle(
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

  ///评论点击
  void _commentAction() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CommentWidget();
        });
  }

  @override
  bool get wantKeepAlive => true;
}
