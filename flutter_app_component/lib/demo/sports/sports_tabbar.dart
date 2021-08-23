import 'package:flutter/material.dart';
import 'package:flutter_app_component/pages/discover/page/discover_page.dart';

import 'sports_tab_home.dart';

/**
 *
 * @author jd
 *
 */

class SportsTabbarPage extends StatefulWidget {
  final String title = "first_page";

  @override
  State createState() => _SportsTabbarPageState();
}

class _SportsTabbarPageState extends State<SportsTabbarPage>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  final _defaultColor = Color(0xff8a8a8a);
  final _activeColor = Color(0xff50b4ed);
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          TabHomePage(),
          DiscoverPage(),
        ],
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: _index == 0 ? Colors.lightBlue : Colors.black,
              onPressed: () {
                _controller.jumpToPage(0);
                setState(() {
                  _index = 0;
                });
              },
            ),
            const SizedBox(), //中间位置空出
            IconButton(
              icon: const Icon(Icons.business),
              color: _index == 1 ? Colors.lightBlue : Colors.black,
              onPressed: () {
                _controller.jumpToPage(1);
                setState(() {
                  _index = 1;
                });
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //悬浮按钮
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
