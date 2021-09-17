import 'package:flutter_app_component/service/environment.dart';
import 'package:get/get.dart';
import 'package:jd_core/jd_core.dart';

import 'model/category.dart';

/// @author jd

class ShopCategoryVM extends GetxController {
  var list = <Category>[].obs;

  @override
  void onReady() {
    loadData();
  }

  Future loadData() async {
    final JDNetworkResponse response =
        await JDNetwork.get(environments.servicesPath.categoryList, mock: true);
    List ls = response.data;
    list.value = ls.map((e) => Category.fromJson(e)).toList();
    return list;
  }
}
