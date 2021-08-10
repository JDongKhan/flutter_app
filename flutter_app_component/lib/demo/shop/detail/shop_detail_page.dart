import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/detail/viewmodel/shop_detail_view_model.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

import 'shop_detail_bottom_bar.dart';
import 'shop_detail_info_widget.dart';
import 'shop_detail_navigator_widget.dart';

/// @author jd

class ShopDetailPage extends StatefulWidget {
  final ShopInfo shopInfo;
  ShopDetailPage(this.shopInfo);
  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  final ShopDetailNavigatorController _controller =
      ShopDetailNavigatorController();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ProviderWidget<ShopDetailViewModel>(
          model: ShopDetailViewModel(),
          builder: (context, model) {
            return _buildContent();
          },
        ),
        bottomNavigationBar: ShopDetailBottomBar(),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        ShopDetailInfoWidget(
          widget.shopInfo,
          navigatorController: _controller,
        ),
        ShopDetailNavigatorWidget(
          controller: _controller,
        ),
      ],
    );
  }
}
