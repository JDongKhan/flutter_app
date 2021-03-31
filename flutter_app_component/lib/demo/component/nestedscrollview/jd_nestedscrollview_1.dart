import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDNestedScrollViewPage1 extends StatefulWidget {

  final String title = "jd_nestedscrollview_1";

  @override
  State createState() => _JDNestedScrollViewPageState1();
}

class _JDNestedScrollViewPageState1 extends State<JDNestedScrollViewPage1> {

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 230.0,
                pinned: true,
               flexibleSpace: FlexibleSpaceBar(
                 title: Text('JD'),
                 background: Image.network(
                   'http://img.haote.com/upload/20180918/2018091815372344164.jpg',
                   fit:BoxFit.fitHeight,
                 ),
               ),
            )
          ];
        },
        body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child:ListView.builder(itemBuilder: (BuildContext context,int index) {
            return Container(
              height: 80,
              color: Colors.primaries[index % Colors.primaries.length],
              alignment: Alignment.center,
              child: Text(
                '$index',
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
            );
          },itemCount: 20,),
        )
    );
  }
}