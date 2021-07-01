import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_view_model.dart';

/// @author jd

abstract class RefreshListViewModel<T> extends ListViewModel<T> {
  /// 总页码
  int totalPageNum = 0;

  /// 当前页码
  int currentPageNum = 0;

  /// 分页条目数量
  final int pageSize = 20;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 下拉刷新
  Future<List<T>> refresh({bool init = false, bool listeners = true}) async {
    //firstInit = init;
    try {
      currentPageNum = 0;
      list.clear();
      var data = await loadData(pageNum: currentPageNum);
      if (init) {
        firstInit = false;
        //改变页面状态为非加载中
        setBusy(false);
      }
      if (data == null || data.isEmpty) {
        setEmpty(listeners: listeners);
      } else {
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        onCompleted(data);
        setComplete(listeners: listeners);
      }
      return data;
    } catch (e, s) {
      setError('请求异常');
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      setBusy(true);
      var data = await loadData(pageNum: ++currentPageNum);
      if (data.isEmpty) {
        currentPageNum--;
        refreshController.loadNoData();
      } else {
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        onCompleted(data);
        setComplete(listeners: true);
      }
      return data;
    } catch (e, s) {
      currentPageNum--;
      refreshController.loadFailed();
      setError('请求异常');
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
