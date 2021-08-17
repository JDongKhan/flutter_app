///刷新控制器
class CustomRefreshController {
  ///调起下拉刷新
  Function() startRefresh;

  ///结束下拉刷新
  Function() closeRefresh;

  ///结束上拉加载
  Function() closeLoadMore;

  ///下拉刷新兼听
  Function() onRefreshListener;

  ///上拉加载更多兼听
  Function() onLoadMoreListener;

  ///设置刷新完成兼听
  Function() onRefreshFinishListener;

  ///设置下拉滑动距离兼听
  Function(double scrollPixe, double totalScrollPixe, bool toDown)
      onScrollListener;

  ///设置下拉刷新兼听
  void setOnRefreshListener(Function() listener) {
    onRefreshListener = listener;
  }

  void setOnLoadMoreListener(Function() listener) {
    onLoadMoreListener = listener;
  }

  ///设置下拉滑动距离兼听
  ///[scrollPixe] 滑动距离兼听
  ///[totalScrollPixe] 总共可滑动的距离
  ///[toDown] true 向下滑动 false 向上滑动
  void setOnScrollListener(
      Function(double scrollPixe, double totalScrollPixe, bool toDown)
          listener) {
    onScrollListener = listener;
  }

  ///设置刷新完成兼听
  void setOnRefreshFinishListener(Function() listener) {
    onRefreshFinishListener = listener;
  }
}
