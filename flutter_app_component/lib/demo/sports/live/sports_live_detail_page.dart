import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/component/orientation/orientation_mixin.dart';
import 'package:flutter_app_component/component/orientation/orientation_observer.dart';
import 'package:jd_core/jd_core.dart';
import 'package:provider/provider.dart';

import 'sports_live_controller.dart';
import 'widget/chat/sports_live_chat_widget.dart';
import 'widget/introduce/sports_live_introduce_widget.dart';
import 'widget/player/sports_live_player_widget.dart';
import 'widget/store/sports_live_store_widget.dart';

/// @author jd

class SportsLiveDetailPage extends StatefulWidget {
  @override
  _SportsLiveDetailPageState createState() => _SportsLiveDetailPageState();
}

class _SportsLiveDetailPageState extends State<SportsLiveDetailPage>
    with SingleTickerProviderStateMixin, OrientationAware, OrientationMixin {
  TabController _tabController; //需要定义一个Controller
  final GlobalKey _globalKey = GlobalKey();

  final String _play_url = 'assets/videos/video_11.mp4';
  final List<Map<String, dynamic>> _tabs = [
    {
      'title': '概况',
      'page': SportsLiveIntroduceWidget(),
    },
    {
      'title': '聊天室',
      'page': SportsLiveChatWidget(),
    },
    {
      'title': '热卖',
      'page': SportsLiveStoreWidget(),
    }
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<SportsLiveController>(
              create: (context) => SportsLiveController()),
        ],
        child: OrientationBuilder(builder: (context, orientation) {
          //修改屏幕方向
          SportsLiveController controller =
              context.read<SportsLiveController>();
          controller.changeOrientation(orientation);
          return Column(
            children: [
              Container(
                height: orientation == Orientation.landscape
                    ? jd_screenHeight()
                    : jd_screenWidth() / 9 * 6,
                child: SportsLivePlayerWidget(
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
            indicatorSize: TabBarIndicatorSize.label,
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

  @override
  List<DeviceOrientation> orientations() {
    return [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ];
  }
}
