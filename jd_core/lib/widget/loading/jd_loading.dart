import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jd_core/widget/skeleton/jd_article_skeleton.dart';
import 'package:jd_core/widget/skeleton/jd_skeleton.dart';

///@author jd

mixin JDLoadingMixin {
  bool isShowLoading = false;

  showLoading() {
    isShowLoading = true;
  }

  stopLoading() {
    isShowLoading = false;
  }

  canShowLoading() {
    return isShowLoading;
  }

  loadingWidget({text}) {
    Widget loading = null;
    if (text != null) {
      loading = JDLoading(
        error: true,
        errorMsg: text,
      );
    }
    loading = SpinKitWave(
      color: Colors.red[100],
      size: 50.0,
    );
    return Container(
      color: Colors.white,
      child: loading,
    );
  }
}

class JDLoading extends StatelessWidget {
  const JDLoading(
      {this.loading = false, this.error = false, this.errorMsg = '暂无数据'});

  final bool loading;
  final bool error;
  final String errorMsg;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !error,
          child: Container(
            child: Center(
              child: Text(errorMsg),
            ),
          ),
        ),
        Offstage(
          offstage: !loading,
          child: SkeletonList(
            builder: (BuildContext context, int index) => ArticleSkeletonItem(),
          ),
        ),
      ],
    );
  }
}
