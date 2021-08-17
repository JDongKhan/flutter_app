import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/circle_check_box.dart';
import 'package:flutter_app_component/component/number_controller/step_number_widget.dart';
import 'package:flutter_app_component/demo/shop/car/car_1/vm/shop_car_view_model.dart';
import 'package:flutter_app_component/demo/shop/model/carI_item.dart';

/// @author jd
class ShopCarItem extends StatefulWidget {
  ShopCarItem(this.carItem, this.viewModel);
  final CarItem carItem;
  final ShopCarViewModel viewModel;
  @override
  _ShopCarItemState createState() => _ShopCarItemState();
}

class _ShopCarItemState extends State<ShopCarItem> {
  @override
  Widget build(BuildContext context) {
    CarItem item = widget.carItem;
    bool checked = item.checked;
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: Colors.white,
      child: Row(
        children: [
          CircleCheckBox(
            value: checked,
            onChanged: (value) {
              widget.viewModel.checkItem(item, value);
              setState(() {});
            },
          ),
          Image.asset(
            item.shopInfo.icon,
            width: 80,
            height: 80,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(item.shopInfo.shop_name),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '商品编码： 000000101029384',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '控油洁面',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '￥${item.shopInfo.price}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StepNumberWidget(
                      min: 0,
                      max: 10,
                      value: item.count,
                      onChanged: (v) {
                        item.count = v;
                        widget.viewModel.notifyListeners();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
