import 'dart:async';

import 'package:flutter/material.dart';

/// @author jd

///倒计时，商品促销使用
class CountDownWidget extends StatefulWidget {
  const CountDownWidget({
    Key key,
    this.time,
    this.prefixString,
    this.suffixString,
  }) : super(key: key);

  final DateTime time;

  final String prefixString;

  final String suffixString;

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  // 用来在布局中显示相应的剩余时间
  String remainTime = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // 初始化的时候开启倒计时
    startCountDown(widget.time);
  }

  @override
  void dispose() {
    super.dispose();
    // 在页面回收或滑动复用回收的时候一定要把 timer 清除
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
        _timer = null;
      }
    }
  }

  @override
  void didUpdateWidget(CountDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 外部重新请求接口后重新进行倒计时，这个方法是用来监控外部 setState 的
    startCountDown(widget.time);
  }

  void startCountDown(time) {
    var nowTime = DateTime.now();
    var endTime = DateTime.parse(time.toString());

    // 如果剩余时间已经不足一分钟，则不必计时，直接标记超时
    if (endTime.millisecondsSinceEpoch - nowTime.millisecondsSinceEpoch <
        1000 * 60) {
      setState(() {
        remainTime = '超时';
      });

      return;
    }

    // 重新计时的时候要把之前的清除掉
    if (_timer != null) {
      if (_timer.isActive) {
        _timer.cancel();
        _timer = null;
      }
    }

    const repeatPeriod = const Duration(seconds: 1);

    caculateTime(nowTime, endTime);

    _timer = Timer.periodic(repeatPeriod, (timer) {
      //到时回调
      nowTime = nowTime.add(repeatPeriod);

      if (endTime.millisecondsSinceEpoch - nowTime.millisecondsSinceEpoch <
          1000 * 60) {
        //取消定时器，避免无限回调
        timer.cancel();
        timer = null;

        setState(() {
          remainTime = '超时';
        });

        return;
      }

      caculateTime(nowTime, endTime);
    });
  }

  /// 计算天数、小时、分钟、秒
  void caculateTime(nowTime, endTime) {
    var _surplus = endTime.difference(nowTime);
    int day = (_surplus.inSeconds ~/ 3600) ~/ 24;
    int hour = (_surplus.inSeconds ~/ 3600) % 24;
    int minute = _surplus.inSeconds % 3600 ~/ 60;
    // 如果用到秒的话计算
    int second = _surplus.inSeconds % 60;

    var str = '';
    if (day > 0) {
      str = day.toString() + '天';
    }
    if (hour > 0 || (day > 0 && hour == 0)) {
      str = str + hour.toString() + '小时';
    }
    str = str + minute.toString() + '分钟';

    str = str + second.toString() + '秒';

    setState(() {
      remainTime = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [];
    if (widget.prefixString != null && widget.prefixString.isNotEmpty) {
      children.add(
        TextSpan(
          text: widget.prefixString,
        ),
      );
    }

    children.add(TextSpan(
      text: remainTime,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ));

    if (widget.suffixString != null && widget.suffixString.isNotEmpty) {
      children.add(
        TextSpan(
          text: widget.suffixString,
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: children,
      ),
    );
  }
}
