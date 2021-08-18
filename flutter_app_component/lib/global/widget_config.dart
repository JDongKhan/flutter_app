import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

/// @author jd

Widget buildPulltoRefreshImage(
    BuildContext context, PullToRefreshScrollNotificationInfo info) {
  var offset = 0.0;
  if (info != null && info.dragOffset != null) {
    offset = info.dragOffset;
  }
  Widget refreshWidget = Container();
  if (info != null && info.refreshWidget != null && offset > 100) {
    refreshWidget = info.refreshWidget;
  }

  String mode = '下拉刷新';
  if (info != null && info.mode != null) {
    switch (info.mode) {
      case RefreshIndicatorMode.refresh:
        mode = '刷新中...';
        break;
      case RefreshIndicatorMode.done:
        mode = '刷新成功';
        break;
      case RefreshIndicatorMode.canceled:
        mode = '刷新取消';
        break;
      case RefreshIndicatorMode.error:
        mode = '刷新错误';
        break;
    }
  }

  return SliverToBoxAdapter(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: offset,
          width: double.infinity,
          child: Image.asset(
            JDAssetBundle.getImgPath('meinv2'),
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          height: offset,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              refreshWidget,
              Container(
                padding: const EdgeInsets.only(left: 5.0),
                alignment: Alignment.center,
                child: Text(
                  mode,
                  style: const TextStyle(
                    fontSize: 12,
                    inherit: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
