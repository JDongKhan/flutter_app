import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/*
 *
 * @author jd
 *
 */

class NestedScrollViewPage1 extends StatefulWidget {
  final String title = 'nestedscrollview_1';

  @override
  State createState() => _NestedScrollViewPageState1();
}

class _NestedScrollViewPageState1 extends State<NestedScrollViewPage1> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 230.0,
                pinned: true,
                title: const Text('JD'),
                flexibleSpace: FlexibleSpaceBar(
                  // title: const Text('JD'),
                  background: Image.asset(
                    JDAssetBundle.getImgPath('cover_4'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            ];
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
