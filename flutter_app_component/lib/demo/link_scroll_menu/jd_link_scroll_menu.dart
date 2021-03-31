import 'package:flutter/material.dart';
import 'package:link_scroll_menu/cc_menu.dart';

class JDLinkScrollMenu extends StatelessWidget {
  GlobalKey<CCMenuPageState> menuState = GlobalKey<CCMenuPageState>();
  List<Color> colorList = [
    Color(0xFF969AF9),
    Color(0xFF53CFA1),
    Color(0xFFFF9E59),
    Color(0xFFFF99CB),
    Color(0xFF80D0FF),
  ];
  List<String> menuList = [
    '关注',
    '推荐',
    '热榜',
    '抗疫',
    '视频',
    '小视频',
    '直播',
    '娱乐',
    '新闻'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: const Text("菜单"),
    );
  }

  Widget _buildBody() {
    return CCMenuPage.custom(
      menuList: menuList,
      tabHeight: 60,
      headerWidget: Container(
        alignment: Alignment.center,
        height: 200,
        color: Colors.black38,
        child: Text(
          '这是头部',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomWidget: Container(
        alignment: Alignment.center,
        height: 200,
        color: Colors.black38,
        child: Text(
          '这是底部',
          style: TextStyle(fontSize: 20),
        ),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          color: colorList[index % colorList.length],
          child: Text(
            '${menuList[index]}',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }
}
