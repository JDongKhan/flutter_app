import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/circle_check_box.dart';
import 'package:flutter_app_component/demo/shop/car/car_1/vm/shop_car_view_model.dart';
import 'package:flutter_app_component/demo/shop/car/car_2/shop_car2_page.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/utils/jd_toast_utils.dart';
import 'package:provider/provider.dart';

/// @author jd

class ShopCarBottomWidget extends StatefulWidget {
  @override
  _ShopCarBottomWidgetState createState() => _ShopCarBottomWidgetState();
}

class _ShopCarBottomWidgetState extends State<ShopCarBottomWidget> {
  @override
  Widget build(BuildContext context) {
    ShopCarViewModel viewModel = context.watch<ShopCarViewModel>();
    return Container(
      height: 60,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      color: Colors.white,
      child: Builder(
        builder: (BuildContext context) {
          return Row(
            children: <Widget>[
              CircleCheckBox(
                value: viewModel.allChecked,
                onChanged: (value) {
                  viewModel.list.forEach((element) {
                    element.checked = value;
                  });
                  viewModel.notifyListeners();
                },
              ),
              const Text('全选'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('总价: ${viewModel.totalPrice.toStringAsFixed(2)}'),
              ),
              const SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) => TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 25,
                      right: 25,
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (viewModel.checkedList.isEmpty) {
                      JDToast.toast('请选择商品');
                      return;
                    }
                    List<ShopInfo> shopInfos =
                        viewModel.checkedList.map((e) => e.shopInfo).toList();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (c) => ShopCar2Page(
                          shopInfoList: shopInfos,
                        ),
                      ),
                    );
                  },
                  child: const Text('去结算'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
