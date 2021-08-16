import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/car/car_1/widget/shop_car_item.dart';
import 'package:flutter_app_component/demo/shop/model/carI_item.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

import 'vm/shop_car_view_model.dart';
import 'widget/shop_car_bottom_widget.dart';

/// @author jd

class ShopCarPage extends StatefulWidget {
  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  final ShopCarViewModel _viewModel = ShopCarViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          title: const Text('购物车'),
          actions: [
            TextButton(
              child: const Text('添加购物车'),
              onPressed: () {
                setState(() {
                  _viewModel.add(
                    CarItem(
                        ShopInfo(
                          icon: JDAssetBundle.getImgPath('defalut_product'),
                          shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
                          price: 48.80,
                        ),
                        1),
                  );
                });
              },
            ),
          ],
        ),
        body: ProviderWidget<ShopCarViewModel>(
          model: _viewModel,
          builder: (BuildContext context, ShopCarViewModel viewModel) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: _buildListItem(),
                ),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
                ShopCarBottomWidget(),
              ],
            );
          },
        ));
  }

  Widget _buildListItem() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: _viewModel.list.length,
        itemBuilder: (context, int index) {
          CarItem item = _viewModel.list[index];
          return ShopCarItem(item, _viewModel);
        },
      ),
    );
  }
}
