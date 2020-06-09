import 'package:flutter/material.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview_2.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview.dart';
import 'package:flutter_component/demo/component/nestedscrollview/jd_nestedscrollview_1.dart';
import 'package:flutter_component/utils/jd_navigation_util.dart';

import 'jd_nestedscrollview_3.dart';

/**
 *
 * @author jd
 *
 */

class JDNestedScrollViewListPage extends StatefulWidget {

  final String title = "jd_nestedscrollview_list";

  @override
  State createState() => _JDNestedScrollViewListPageState();
}

class _JDNestedScrollViewListPageState
    extends State<JDNestedScrollViewListPage> {

  List<dynamic> itemsList = <dynamic>[
    {
      "title" : "普通的",
      "page" : JDNestedScrollViewPage()
    },
    {
      "title" : "普通的-1",
      "page" : JDNestedScrollViewPage1()
    },
    {
      "title" : "普通的-2",
      "page" : JDNestedScrollViewPage2()
    },
    {
      "title" : "普通的-3",
      "page" : LoadMoreDemo()
    }
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
            itemBuilder: (BuildContext context,int index) {
                  return ListTile(
                    title: Text('${itemsList[index]['title']}'),
                    onTap: (){
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