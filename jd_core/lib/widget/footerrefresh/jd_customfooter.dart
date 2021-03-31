import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 *
 * @author jd
 *
 */

class JDCustomFooter extends CustomFooter {
  //目的是不想到处写这么多代码
  JDCustomFooter():super(builder:(context,mode) {
    Widget b;
    if (mode == LoadStatus.idle) {
      b = Text('pull up load');
    } else if (mode == LoadStatus.loading) {
      b = CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      b = Text('Load Failed! Click retry');
    } else {
      b = Text('No more Data');
    }
    return Container(
      height: 55.0,
      child: Center(child: b,),
    );
  });
}
