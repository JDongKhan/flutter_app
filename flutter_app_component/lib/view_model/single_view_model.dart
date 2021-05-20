import 'package:flutter/cupertino.dart';

import 'view_model.dart';

/// @author jd

abstract class SingleViewModel<T> extends ViewModel {
  T data;

  Future<T> initData() async {
    setBusy(true);
    await fetchData(fetch: true);
  }

  Future<T> fetchData({bool fetch = false}) async {
    try {
      T temp = await loadData();
      if (fetch) {
        setBusy(false);
      }
      if (temp == null) {
        setEmpty();
      } else {
        data = temp;
        setComplete();
        onCompleted(temp);
      }
      return data;
    } catch (e, s) {
      setError('请求异常');
      debugPrint('error--->\n' + e.toString());
    }
  }

  Future<T> loadData();

  void onCompleted(T data);
}
