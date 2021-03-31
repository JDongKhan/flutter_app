import 'package:flutter/material.dart';
import 'package:jd_home/models/home_model.dart';

/**
 *
 * @author jd
 *
 */

class HomeViewModel extends ChangeNotifier {
  HomeModel homeModel;
  HomeModelList homeModelList;

  void saveBanner(HomeModel homeModel) {
    this.homeModel = homeModel;
    notifyListeners();
  }

  void saveList(HomeModelList homeModelList) {
    this.homeModelList = homeModelList;
    notifyListeners();
  }

  void loadMore(HomeModelList homeModelList) {
    this.homeModelList.addOtherList(homeModelList.list);
    notifyListeners();
  }
}
