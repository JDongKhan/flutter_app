import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_customrefresh.dart';

/**
 *
 * @author jd
 *
 */

class JDNestedScrollViewPage2 extends StatefulWidget {

  final String title = "jd_nestedscrollview_2";

  @override
  State createState() => _JDNestedScrollViewPage2State();
}

class _JDNestedScrollViewPage2State extends State<JDNestedScrollViewPage2> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    this._tabController = TabController(length: 2,vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        /// android 需要设置弹簧效果 overlap 才会起作用
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
         slivers: <Widget>[
           CustomRefreshWidget (
             child: Container(
               height: 100,
               color: Colors.purple,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,

                 children: <Widget>[
                   Text(
                     "RefreshWidget",
                     style: TextStyle(color: Colors.white),
                   ),
                   Padding(
                     padding: EdgeInsets.only(left: 10.0),
                     child: CupertinoActivityIndicator(),
                   )
                 ],
               ),
             ),
           ),
           _buildListView()
         ],
    ));
  }

  Widget _buildListView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate( (context,index) {
        return ListTile(title: Text('test : ${index}'));
        },
        childCount: 10
      ),
    );
  }

}
