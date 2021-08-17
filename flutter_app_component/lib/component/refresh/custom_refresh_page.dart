import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_timer_utils.dart';

import 'custom_refresh_controller.dart';

export 'custom_refresh_controller.dart';

///下拉刷新状态控制
enum RefreshState {
  normal,
  refresh,
  todown,
  toup,
}

class CustomRefreshPage extends StatefulWidget {
  ///子控件
  Widget child;

  ///刷新控制器
  CustomRefreshController customRefreshController;

  ScrollController listViewScrollController;

  ///是否输出日志
  bool isRefreshLog;

  ///刷新圆圈的大小
  double progressIconSize;
  Color progressColor;
  Color backgroundColor;

  double progressFooterIconSize;
  Color progressFooterColor;
  Color backgroundFooterColor;

  ///是否需要显示加载加载更多圆圈
  bool useShowLoadMore = false;

  CustomRefreshPage({
    @required this.child,
    this.customRefreshController,
    this.isRefreshLog = false,
    this.useShowLoadMore = false,
    this.progressIconSize = 28,
    this.progressColor,
    this.backgroundColor,
    this.progressFooterIconSize = 28,
    this.progressFooterColor,
    this.backgroundFooterColor,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomRefreshPageState();
  }
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  CustomRefreshController customRefreshController;

  ///用于计算的最大下拉距离
  double defaultHeight = 40;

  double defaultFooterHeight = 40;

  ///当前下拉的距离
  double offestHeight = 0;

  ///当前刷新圆圈的进度
  double cirProgress = 0;

  ///当前刷新圆圈的透明度
  double offestOpacity = 0;

  ///计时时间 动画进行时间
  int animationTime = 500;

  ///上一次滑动的距离
  double preScrollPixe = 0;

  ///true 显示加载更多 flase 不显示
  bool isShowLoadMore = false;

  ///是否正在加载中
  bool isLoadInding = false;

  RefreshState currentRefreshState = RefreshState.normal;

  ScrollController scrollController = new ScrollController();

  Widget buildScroll(Widget childWidget) {
    return Scrollbar(
      //进度条
      /// 监听滚动通知
      child: NotificationListener<ScrollNotification>(

          ///监控到notification后的回调方法。
          onNotification: (ScrollNotification notification) {
            ScrollMetrics metrics = notification.metrics;
            // 当前位置
            double pixels = metrics.pixels;

            ///视口底部距离列表底部有多大
            double extentAfter = metrics.extentAfter;
            //视口顶部距离列表顶部有多大
            double extentBefore = metrics.extentBefore;
            //视口范围内的列表长度
            double extentInside = metrics.extentInside;
            //视口长度
            double viewportDimension = metrics.viewportDimension;
            //是否在顶部或底部
            bool atEdge = metrics.atEdge;
            //垂直或水平滚动
            Axis axis = metrics.axis;
            // 滚动方向是down还是up
            AxisDirection axisDirection = metrics.axisDirection;

            //是否越过边界
            bool outOfRange = metrics.outOfRange;

            //最大滚动距离，列表长度-视口长度
            double maxScrollExtent = metrics.maxScrollExtent;
            //最小滚动距离
            double minScrollExtent = metrics.minScrollExtent;

//            print(
//                "是否越过边界 $outOfRange 当前位置 $pixels 是否在顶部或底部$atEdge 视口底部距离列表底部 $extentAfter 视口顶部距离列表顶部有多大 $extentBefore 列表长度 $extentInside");
            print('------------------------');

            if (outOfRange) {
              //重新构建
              controllNotification(notification);
            }
            return false;
          },

          ///被监控的子widget树
          child: childWidget),
    );
  }

  ///自定义下拉刷新回调
  void onCustomRefresh() {
    if (widget.customRefreshController != null &&
        widget.customRefreshController.onRefreshListener != null) {
      widget.customRefreshController.onRefreshListener();
    }
  }

  ///开始下拉刷新
  void startRefresh() {
    ///创建计时 TimerUtil
    TimerUtil timerUtil = TimerUtil(mInterval: 100, mTotalTime: animationTime);

    ///设置计时回调
    timerUtil.setOnTimerTickCallback((value) {
      ///计算下拉刷新的控件的透明度
      offestOpacity = value / animationTime;

      ///透明度为1的时候开始刷新
      if (offestOpacity == 1) {
        ///更新刷新状态
        currentRefreshState = RefreshState.refresh;

        ///开始刷新时回调
        if (widget.customRefreshController != null &&
            widget.customRefreshController.onRefreshListener != null) {
          widget.customRefreshController.onRefreshListener();
        }
      }
      setState(() {});
    });

    ///开始正计时
    /// 0- 500
    timerUtil.startTimer();
  }

  ///结束下拉刷新
  void closeRefresh() {
    ///创建计时 TimerUtil
    TimerUtil timerUtil =
        new TimerUtil(mInterval: 100, mTotalTime: animationTime);

    ///设置计时回调
    timerUtil.setOnTimerTickCallback((value) {
      ///计算下拉刷新的控件的透明度
      offestOpacity = value / animationTime;

      ///透明度为0的时候刷新结束 恢复正常
      if (offestOpacity == 0) {
        ///更新刷新状态
        currentRefreshState = RefreshState.normal;

        ///刷新状态结束回调
        if (widget.customRefreshController != null &&
            widget.customRefreshController.onRefreshFinishListener != null) {
          widget.customRefreshController.onRefreshFinishListener();
        }
      }
      setState(() {});
    });

    ///开始倒计时
    /// 500 -0
    timerUtil.startCountDown();
  }

  @override
  void initState() {
    super.initState();
    if (widget.customRefreshController != null) {
      widget.customRefreshController.startRefresh = () {
        startRefresh();
      };

      widget.customRefreshController.closeRefresh = () {
        closeRefresh();
      };
      widget.customRefreshController.closeLoadMore = () {
        setState(() {
          isShowLoadMore = false;
          isLoadInding = false;
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      buildScroll(widget.child),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: offestOpacity * defaultHeight),
            height: widget.progressIconSize,
            width: widget.progressIconSize,
            child: Opacity(
              opacity: offestOpacity,
              child: CircularProgressIndicator(
                value: cirProgress,
                backgroundColor:
                    widget.backgroundColor ?? Theme.of(context).primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                    widget.progressColor ?? Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: Container(
            margin: EdgeInsets.only(bottom: defaultFooterHeight),
            height: widget.progressFooterIconSize,
            width: widget.progressFooterIconSize,
            child: Opacity(
              opacity: widget.useShowLoadMore ? (isShowLoadMore ? 1.0 : 0) : 0,
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(
                    widget.progressColor ?? Theme.of(context).accentColor),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  ///日志输出
  void logd(String message) {
    if (widget.isRefreshLog) {
      print("----【刷新组件】 $message");
    }
  }

  void controllNotification(ScrollNotification notification) {
    ///当前滑动的距离
    double scrollPixe = notification.metrics.pixels;

    ///当前可滑动的最大距离
    double totalScrollPixe = notification.metrics.maxScrollExtent;

    ///当前滑动的进度比
    double progress = scrollPixe / totalScrollPixe;

    ///只有向上滑动时 才会有上拉加载更多
    if (scrollPixe > totalScrollPixe && !isLoadInding) {
      ///加载更多数据回调
      if (widget.customRefreshController != null &&
          widget.customRefreshController.onLoadMoreListener != null) {
        widget.customRefreshController.onLoadMoreListener();

        ///正在加载中
        isLoadInding = true;

        ///显示加载更多圆圈
        if (widget.useShowLoadMore) {
          isShowLoadMore = true;
          setState(() {});
        }
        return;
      }
    }

    ///只有是向下滑动的时候才启动下拉刷新
    if (scrollPixe < 0) {
      if (currentRefreshState == RefreshState.normal ||
          currentRefreshState == RefreshState.todown) {
        if (scrollPixe.abs() < defaultHeight / 2) {
          ///从0到1
          offestOpacity = scrollPixe.abs() / (defaultHeight / 2);

          ///进度一直可以是0
          offestHeight = 0;
        } else {
          ///为1
          offestOpacity = 1.0;

          ///进度转变
          offestHeight = scrollPixe.abs() / 2;
          if (offestHeight > defaultHeight) {
            offestHeight = defaultHeight + 1;
            if (currentRefreshState != RefreshState.refresh) {
              currentRefreshState = RefreshState.refresh;
              onCustomRefresh();
            }
          }
        }
      } else {
        offestOpacity = 1.0;
        offestHeight = defaultHeight;
      }

      ///滑动方向计算
      double flagScrollPixe = scrollPixe.abs() - preScrollPixe;

      ///保存滑动标识
      preScrollPixe = scrollPixe.abs();
      if (flagScrollPixe > 0) {
        ///向下滑动
        ///正常向下滑动
        logd("向下");

        ///设置回调
        if (widget.customRefreshController != null &&
            widget.customRefreshController.onScrollListener != null) {
          widget.customRefreshController
              .onScrollListener(scrollPixe, totalScrollPixe, true);
        }
      } else {
        ///向上滑动
        logd("向上");

        ///设置回调
        if (widget.customRefreshController != null &&
            widget.customRefreshController.onScrollListener != null) {
          widget.customRefreshController
              .onScrollListener(scrollPixe, totalScrollPixe, false);
        }
        if (currentRefreshState == RefreshState.refresh) {
          offestHeight = null;
        }
      }
      if (offestHeight != null) {
        cirProgress = offestHeight / defaultHeight;
      } else {
        cirProgress = null;
      }
      setState(() {});
    }
  }
}
