import 'dart:async';

/// @author jd

///防抖
void Function() debounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer timer;
  void Function() target = () {
    timer?.cancel();
    timer = Timer(delay, () {
      func.call();
    });
  };
  return target;
}

///节流
Function throttle(
  Function func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer timer;
  return () {
    if (timer != null) return;
    timer = Timer(delay, () {
      func.call();
    });
  };
}
