import 'package:flutter_app_component/view_model/view_model.dart';

/// @author jd

abstract class ListViewModel<T> extends ViewModel {
  /// 页面数据
  List<T> list = [];

  ///第一次加载
  bool firstInit = true;

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy(true);
    await refresh(init: true);
  }

  // 下拉刷新
  Future<List<T>> refresh({bool init = false}) async {
    //firstInit = init;
    try {
      List<T> data = await loadData();
      if (init) {
        firstInit = false;
        //改变页面状态为非加载中
        setBusy(false);
      }
      if (data.isEmpty) {
        setEmpty();
      } else {
        list = data;
        onCompleted(data);
        setComplete();
      }
      return data;
    } catch (e, s) {
      setError('请求异常');
      print(e);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  ///数据获取后会调用此方法,此方法在notifyListeners（）之前
  void onCompleted(List<T> data) {}
}
