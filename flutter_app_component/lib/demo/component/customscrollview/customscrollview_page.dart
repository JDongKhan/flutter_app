import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/component/customscrollview/section_customscrollview_page.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import 'custom_refresh_page.dart';
import 'customscrollview_page_2.dart';
import 'thirdparty_tableview_demo_page.dart';

/**
 *
 * @author jd
 *
 */

class CustomScrollViewPage extends StatefulWidget {
  final String title = "customscrollview";

  @override
  State createState() => _CustomScrollViewPageState();
}

class _CustomScrollViewPageState extends State<CustomScrollViewPage> {
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  final List _menu = [
    {
      'title': 'SectionTableView',
      'page': SectionTableView(),
    },
    {
      'title': 'TableView',
      'page': ThirdPartyTableViewDemoPage(),
    },
    {
      'title': 'CustomScrollView2Demo',
      'page': CustomScrollViewPage2(),
    },
    {
      'title': 'CustomRefreshWidget',
      'page': CustomRefreshPage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      debugPrint(_controller.offset.toString()); //打印滚动位置
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                'assets/images/head.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              //Grid
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  Map map = _menu[index % _menu.length];
                  //创建子widget
                  return InkWell(
                    onTap: () {
                      _tap(map);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('${map['title']}'),
                    ),
                  );
                },
                childCount: _menu.length * 5,
              ),
            ),
          ),
          //List
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              //创建列表项
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                    ),
          ),
        ],
      ),
    );
  }

  void _tap(map) {
    Widget widget = map['page'];
    JDNavigationUtil.push(widget);
  }
}
