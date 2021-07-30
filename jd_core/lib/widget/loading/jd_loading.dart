import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jd_core/widget/skeleton/jd_article_skeleton.dart';
import 'package:jd_core/widget/skeleton/jd_skeleton.dart';

///@author jd

mixin JDLoadingMixin {
  bool isShowLoading = false;

  void showLoading() {
    isShowLoading = true;
  }

  void stopLoading() {
    isShowLoading = false;
  }

  bool canShowLoading() {
    return isShowLoading;
  }

  Widget loadingWidget({text}) {
    Widget loading = null;
    if (text != null) {
      loading = JDLoadingWidget(
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

class JDLoadingWidget extends StatelessWidget {
  const JDLoadingWidget({
    this.loading = false,
    this.error = false,
    this.errorMsg = '暂无数据',
  });

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

class Loading {
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black54,
                ),
                width: 64,
                height: 64,
                child: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: CupertinoActivityIndicator(
                    radius: 14,
                  ),
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white.withAlpha(100),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
