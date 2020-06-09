import 'package:flutter/material.dart';
import 'package:flutter_component/widget/skeleton/jd_article_skeleton.dart';
import 'package:flutter_component/widget/skeleton/jd_skeleton.dart';

/**
 *
 * @author jd
 *
 */

class JDLoading extends StatelessWidget {

  JDLoading(this.loading,{this.nodata = false});

  bool loading;
  bool nodata;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !this.nodata,
          child: Container(
            child: Center(
              child: Text('暂无数据'),
            ),
          ),
        ),
        Offstage(
          offstage: !this.loading,
          child: SkeletonList(
            builder: (context, index) => ArticleSkeletonItem(),
          ),
        ),
      ],
    );
  }

}
