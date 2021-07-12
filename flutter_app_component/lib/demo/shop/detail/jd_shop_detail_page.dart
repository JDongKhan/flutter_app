import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/detail/viewmodel/jd_shop_detail_view_model.dart';
import 'package:flutter_app_component/demo/shop/model/jd_shop_info.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ProviderWidget<JDShopDetailViewModel>(
          model: JDShopDetailViewModel(),
          builder: (context, model) {
            return _buildContent();
          },
        ),
        bottomNavigationBar: JDShopDetailBottomBar(),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        JDShopDetailInfoWidget(
          widget.shopInfo,
          navigatorController: _controller,
        ),
        JDShopDetailNavigatorWidget(
          controller: _controller,
        ),
      ],
    );
  }
}
