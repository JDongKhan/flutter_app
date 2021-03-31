import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/component/customscrollview/jd_section_customscrollview.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import 'jd_customscrollview2.dart';

/**
 *
 * @author jd
 *
 */

class JDCustomScrollViewPage extends StatefulWidget {
  final String title = "customscrollview";

  @override
  State createState() => _JDCustomScrollViewPageState();
}

class _JDCustomScrollViewPageState extends State<JDCustomScrollViewPage> {
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); //打印滚动位置
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
            actions: <Widget>[
              FlatButton(
                child: const Text('SectionTableView'),
                onPressed: () {
                  JDNavigationUtil.push(JDSectionTableView());
                },
              ),
            ],
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
                  //创建子widget
                  return InkWell(
                    onTap: () {
                      _tap(index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('grid item $index'),
                    ),
                  );
                },
                childCount: 60,
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

  void _tap(int index) {
    if (index == 0) {
      JDNavigationUtil.push(JDCustomScrollView2Demo());
    }
  }
}
