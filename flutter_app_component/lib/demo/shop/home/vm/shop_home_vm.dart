import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/view_model/single_view_model.dart';
import 'package:jd_core/widget/scroll/jd_primary_scroll.dart';

/// @author jd

class ShopHomeVM extends SingleViewModel {
  String searchText;

  final List<Map<String, dynamic>> tabs = <Map<String, dynamic>>[
    {
      'title': '推荐',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '投影仪',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '家用电器',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '服装',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '冰箱',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
    {
      'title': '其他',
      'key': GlobalKey<PrimaryScrollContainerState>(),
    },
  ];

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

  void onPageChange(int currentIndex) {
    for (int i = 0; i < tabs.length; i++) {
      GlobalKey<PrimaryScrollContainerState> key =
          tabs[i]['key'] as GlobalKey<PrimaryScrollContainerState>;
      if (key != null && key.currentState != null) {
        key.currentState.onPageChange(currentIndex == i);
      }
    }
  }

  Future<bool> onRefresh() async {
    print('开始刷新了');
    // _globalKey.currentState.show(notificationDragOffset: 200);
    await initData();
    return true;
  }

  @override
  Future loadData() {
    return Future.delayed(const Duration(seconds: 2), () {
      print('请求完数据');
    });
  }

  @override
  void onCompleted(data) {
    print(data);
  }
}
