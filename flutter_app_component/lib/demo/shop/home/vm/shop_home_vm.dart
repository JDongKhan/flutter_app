import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:flutter_app_component/service/environment.dart';
import 'package:get/get.dart';
import 'package:jd_core/network/jd_network_utils.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';

/// @author jd

class ShopHomeVM extends GetxController {
  String searchText;

  var tabs = <Map<String, dynamic>>[].obs;

  final List<ShopInfo> recommendList = [
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_0'),
      shop_name: '洗发水-你值得拥有',
      price: 18.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_1'),
      shop_name: '蛋糕-好吃到爆',
      price: 8.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_2'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_3'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
    ShopInfo(
      icon: JDAssetBundle.getImgPath('shop_4'),
      shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
      price: 48.80,
    ),
  ];

  Future<bool> onRefresh() async {
    print('开始刷新了');
    // _globalKey.currentState.show(notificationDragOffset: 200);
    await loadData();
    return true;
  }

  Future loadData() async {
    final JDNetworkResponse response =
        await JDNetwork.get(environments.servicesPath.categoryList, mock: true);
    List list = response.data;
    tabs.value = list
        .map((e) => {
              'title': e['name'],
            })
        .toList();
    return list;
  }
}
