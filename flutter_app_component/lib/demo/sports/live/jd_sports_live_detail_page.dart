import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_core/jd_core.dart';
import 'package:provider/provider.dart';

import 'jd_sports_live_controller.dart';
import 'widget/jd_sports_live_chat_widget.dart';
import 'widget/jd_sports_live_introduce_widget.dart';
import 'widget/jd_sports_live_store_widget.dart';
import 'widget/player/jd_sports_live_player_widget.dart';

/// @author jd

class JDSportsLiveDetailPage extends StatefulWidget {
  @override
  _JDSportsLiveDetailPageState createState() => _JDSportsLiveDetailPageState();
}

class _JDSportsLiveDetailPageState extends State<JDSportsLiveDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  JDSportsLiveController _controller = JDSportsLiveController();
  GlobalKey _globalKey = GlobalKey();

  String _play_url = 'assets/videos/video_11.mp4';
  final List<Map<String, dynamic>> _tabs = [
    {
      'title': '概况',
      'page': JDSportsLiveIntroduceWidget(),
    },
    {
      'title': '聊天室',
      'page': JDSportsLiveChatWidget(),
    },
    {
      'title': '热卖',
      'page': JDSportsLiveStoreWidget(),
    }
  ];

  JDSportsLivePlayerWidget _playerWidget;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
    _playerWidget = JDSportsLivePlayerWidget(
      url: _play_url,
      key: _globalKey,
    );
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<JDSportsLiveController>(
              create: (context) => JDSportsLiveController()),
        ],
        child: OrientationBuilder(builder: (context, orientation) {
          //修改屏幕方向
          JDSportsLiveController controller =
              context.read<JDSportsLiveController>();
          controller.changeOrientation(orientation);
          return Column(
            children: [
              Container(
                height: orientation == Orientation.landscape
                    ? jd_screenHeight()
                    : 250,
                child: JDSportsLivePlayerWidget(
                  url: _play_url,
                  key: _globalKey,
                ),
              ),
              Expanded(child: _buildContentWidget()),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TabBar(
            //生成Tab菜单
            isScrollable: true,
            labelColor: Colors.black,
            controller: _tabController,
            tabs: _tabs
                .map(
                  (e) => Tab(
                    text: e['title'].toString(),
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((e) {
                //创建3个Tab页
                return e['page'] as Widget;
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
