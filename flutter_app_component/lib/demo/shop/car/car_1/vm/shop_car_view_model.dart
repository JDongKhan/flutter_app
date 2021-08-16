import 'package:flutter_app_component/demo/shop/model/carI_item.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';

/// @author jd

class ShopCarViewModel extends RefreshListViewModel<CarItem> {
  // 禁止改变购物车里的商品信息
//  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  //选中列表
  List<CarItem> get checkedList =>
      list.where((element) => element.checked).toList();

  //购物车中商品的总价
  double get totalPrice => checkedList.fold(
      0, (value, item) => value + item.count * item.shopInfo.price);

  //是否全部选中
  bool get allChecked => list.every((element) => element.checked);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(CarItem item) {
    list.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void addAll(List<CarItem> list) {
    this.list.addAll(list);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  void checkItem(CarItem item, bool checked) {
    item.checked = checked;
    notifyListeners();
  }

  void remove(CarItem item) {
    list.remove(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  @override
  Future<List<CarItem>> loadData({int pageNum}) async {
    List<CarItem> list = [
      CarItem(
          ShopInfo(
            icon: JDAssetBundle.getImgPath('defalut_product'),
            shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
            price: 48.80,
          ),
          1),
    ];
    return list;
  }
}
