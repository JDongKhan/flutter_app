import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// @author jd

class SportsLiveController extends GetxController {
  Orientation orientation = Orientation.portrait;

  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;

  void changeOrientation(Orientation orientation) {
    this.orientation = orientation;
    //不需要更新 转屏本身就要重建
    // update();
    // notifyListeners();
  }

  void changeDuration(Duration position, Duration duration) {
    this.position.value = position;
    this.duration.value = duration;
  }
}
