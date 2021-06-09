import 'package:flutter/cupertino.dart';

import 'view_model.dart';

/// @author jd

abstract class SingleViewModel<T> extends ViewModel {
  T data;

  Future<T> initData({bool listeners = true}) async {
    setBusy(true);
    await fetchData(fetch: true, listeners: listeners);
  }

  Future<T> fetchData({bool fetch = false, bool listeners = true}) async {
    try {
      T temp = await loadData();
      if (fetch) {
        setBusy(false);
      }
      if (temp == null) {
        setEmpty(listeners: listeners);
      } else {
        data = temp;
        onCompleted(temp);
        setComplete(listeners: listeners);
      }
      return data;
    } catch (e, s) {
      setError('请求异常', listeners: listeners);
      debugPrint('error--->\n' + e.toString());
    }
  }

  Future<T> loadData();

  void onCompleted(T data);
}
