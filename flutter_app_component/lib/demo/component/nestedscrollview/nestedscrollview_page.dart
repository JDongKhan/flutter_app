import 'package:flutter/material.dart';

/*
 *
 * @author jd
 *
 */

class NestedScrollViewPage extends StatefulWidget {
  final String title = 'nestedscrollview';

  @override
  State createState() => _NestedScrollViewPageState();
}

class _NestedScrollViewPageState extends State<NestedScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    //不在Scaffold下面会导致文本下面有多余的下划线
    return Material(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[SliverAppBar(title: Text("JD"))];
          },
          body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 80,
                  color: Colors.primaries[index % Colors.primaries.length],
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              },
              itemCount: 20,
            ),
          )),
    );
  }
}
