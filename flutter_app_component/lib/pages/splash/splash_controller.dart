import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class SplashController extends ChangeNotifier {
  ///timeutil
  TimerUtil _timerUtil;

  ///引导页
  final List<String> guideList = <String>[
    JDAssetBundle.getImgPath('guide1'),
    JDAssetBundle.getImgPath('guide2'),
    JDAssetBundle.getImgPath('guide3'),
    JDAssetBundle.getImgPath('guide4'),
  ];

  ///倒计时数
  int count = 5;

  ///是否显示广告
  bool showAd = true;

  ///初始化数据
  void initState() {
    if (showAd) {
      _doCountDown();
    }
  }

  ///倒计时
  void _doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: 5 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      final double _tick = tick / 1000;
      count = _tick.toInt();
      notifyListeners();
    });
    _timerUtil.startCountDown();
    // Future.delayed(Duration(seconds: 5), () => _goMain());
  }

  @override
  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
    super.dispose();
  }
}
