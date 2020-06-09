import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDNestedScrollViewPage extends StatefulWidget {

  final String title = "jd_nestedscrollview";

  @override
  State createState() => _JDNestedScrollViewPageState();
}

class _JDNestedScrollViewPageState extends State<JDNestedScrollViewPage> {

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(title:Text("JD"))
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