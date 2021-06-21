import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/tab/jd_tab_home.dart';
import 'package:flutter_app_component/pages/discover/jd_discover_page.dart';

/**
 *
 * @author jd
 *
 */

class JDTabbarPage extends StatefulWidget {
  final String title = "first_page";

  @override
  State createState() => _JDTabbarPageState();
}

class _JDTabbarPageState extends State<JDTabbarPage>
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
          JDTabHomePage(),
          JDDiscoverPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: _index == 0 ? Colors.lightBlue : Colors.black,
              onPressed: () {
                _controller.jumpToPage(0);
                setState(() {
                  _index = 0;
                });
              },
            ),
            SizedBox(), //中间位置空出
            IconButton(
                icon: Icon(Icons.business),
                color: _index == 1 ? Colors.lightBlue : Colors.black,
                onPressed: () {
                  _controller.jumpToPage(1);
                  setState(() {
                    _index = 1;
                  });
                }),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: () {}),
    );
  }
}
