import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

import 'bottom_drag_widget.dart';

/// @author jd

/// DragController controller = DragController();
class BottomDragDemo extends StatefulWidget {
  @override
  _BottomDragDemoState createState() => _BottomDragDemoState();
}

class _BottomDragDemoState extends State<BottomDragDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomDrag'),
      ),
      body: BottomDragWidget(
          body: Container(
            color: Colors.brown,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text('我是listview下面一层的东东，index=$index');
              },
              itemCount: 100,
            ),
          ),
          dragContainer: DragContainer(
            drawer: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  margin: const EdgeInsets.only(top: 40),
                ),
                getListView(),
              ],
            ),
            defaultShowHeight: 150.0,
            height: 700.0,
          )),
    );
  }

  Widget getListView() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildUserHeadWidget(),
          Expanded(child: _buildDragList())
        ],
      ),
    );
  }

  Widget newListView() {
    return OverscrollNotificationWidget(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text('data=$index');
        },
        itemCount: 100,

        ///这个属性是用来断定滚动的部件的物理特性，例如：
        ///scrollStart
        ///ScrollUpdate
        ///Overscroll
        ///ScrollEnd
        ///在Android和ios等平台，其默认值是不同的。我们可以在scroll_configuration.dart中看到如下配置

        ///下面代码是我在翻源码找到的解决方案
        /// The scroll physics to use for the platform given by [getPlatform].
        ///
        /// Defaults to [BouncingScrollPhysics] on iOS and [ClampingScrollPhysics] on
        /// Android.
//  ScrollPhysics getScrollPhysics(BuildContext context) {
//    switch (getPlatform(context)) {
//    case TargetPlatform.iOS:/*/
//         return const BouncingScrollPhysics();
//    case TargetPlatform.android:
//    case TargetPlatform.fuchsia:
//        return const ClampingScrollPhysics();
//    }
//    return null;
//  }
        ///在ios中，默认返回BouncingScrollPhysics，对于[BouncingScrollPhysics]而言，
        ///由于   double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;
        ///会导致：当listview的第一条目显示时，继续下拉时，不会调用上面提到的Overscroll监听。
        ///故这里，设定为[ClampingScrollPhysics]
        physics: const ClampingScrollPhysics(),
      ),
    );
  }

  Widget _buildUserHeadWidget() {
    return Container(
      height: 150,
      child: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            margin: const EdgeInsets.only(top: 60),
          ),
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    JDAssetBundle.getImgPath('user_head_0'),
                    width: 80,
                    height: 80,
                  ),
                ),
                const Text(
                  '欢迎回来',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 30),
                ),
                const Text(
                  '看看你都错过了哪些精彩内容',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragList() {
    return GridView.builder(
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(
              10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                JDAssetBundle.getImgPath('user_head_${index % 5}'),
              ),
            ),
          );
        },
        itemCount: 40,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120,
        ));
  }
}
