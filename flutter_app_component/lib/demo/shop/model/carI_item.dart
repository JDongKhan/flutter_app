import 'package:flutter_app_component/demo/shop/model/shop_info.dart';

/// @author jd

class CarItem {
  CarItem(this.shopInfo, this.count);
  int count; // 商品份数
  ShopInfo shopInfo; //商品信息
  bool checked = false; //是否选中
//... 省略其它属性
}
