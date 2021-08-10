import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';

import 'nestedscrollview_page.dart';
import 'nestedscrollview_page_1.dart';
import 'nestedscrollview_page_2.dart';
import 'nestedscrollview_page_3.dart';
import 'nestedscrollview_page_4.dart';
import 'nestedscrollview_page_5.dart';
import 'sliver_list_demo_page.dart';

/**
 *
 * @author jd
 *
 */

class NestedScrollViewListPage extends StatefulWidget {
  final String title = "jd_nestedscrollview_list";

  @override
  State createState() => _NestedScrollViewListPageState();
}

class _NestedScrollViewListPageState extends State<NestedScrollViewListPage> {
  List<dynamic> itemsList = <dynamic>[
    {"title": "普通的", "page": NestedScrollViewPage()},
    {"title": "普通的-1", "page": NestedScrollViewPage1()},
    {"title": "普通的-2", "page": NestedScrollViewPage2()},
    {"title": "普通的-3", "page": LoadMoreDemo()},
    {"title": "普通的-4", "page": NestedScrollView4Demo()},
    {"title": "普通的-5", "page": NestedScrollView5Demo()},
    {"title": "普通的-6", "page": SliverListDemoPage()},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${itemsList[index]['title']}'),
            onTap: () {
              _pushSaved(itemsList[index]['page'] as Widget);
            },
          );
        },
        itemCount: itemsList.length,
        separatorBuilder: (context, index) => Divider(height: .0),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _pushSaved(Widget page) {
    JDNavigationUtil.push(page);
  }
}
