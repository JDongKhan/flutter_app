import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 *
 * @author jd
 *
 */

class ShopHomeItem4Footer extends CustomFooter {
  //目的是不想到处写这么多代码
  ShopHomeItem4Footer()
      : super(
          builder: (context, mode) {
            Widget b;
            if (mode == LoadStatus.idle) {
              b = const Text(
                '左滑查看更多',
                style: TextStyle(color: Colors.grey),
              );
            } else if (mode == LoadStatus.loading) {
              b = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              b = const Text(
                '加载失败',
                style: TextStyle(color: Colors.grey),
              );
            } else {
              b = const Text(
                '松手查看更多',
                style: TextStyle(color: Colors.grey),
              );
            }
            return Container(
              child: Row(
                children: [
                  Container(
                    width: 2,
                    height: 50,
                    margin: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    color: Colors.blueGrey,
                  ),
                  Container(
                    width: 20.0,
                    child: b,
                  ),
                ],
              ),
            );
          },
        );
}
