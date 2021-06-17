import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/model/jd_shop_info.dart';

import 'jd_shop_detail_bottom_bar.dart';
import 'jd_shop_detail_info_widget.dart';
import 'jd_shop_detail_navigator_widget.dart';

/// @author jd

class JDShopDetailPage extends StatefulWidget {
  final JDShopInfo shopInfo;
  JDShopDetailPage(this.shopInfo);
  @override
  _JDShopDetailPageState createState() => _JDShopDetailPageState();
}

class _JDShopDetailPageState extends State<JDShopDetailPage> {
  JDShopDetailNavigatorController _controller =
      JDShopDetailNavigatorController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          JDShopDetailInfoWidget(
            widget.shopInfo,
            navigatorController: _controller,
          ),
          JDShopDetailNavigatorWidget(
            controller: _controller,
          ),
        ],
      ),
      bottomNavigationBar: JDShopDetailBottomBar(),
    );
  }
}
