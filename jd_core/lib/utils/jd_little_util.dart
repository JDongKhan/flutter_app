import 'dart:async';

class JDLittleUtil {
  ///简单的循环执行一个task
  static StreamSubscription cycleUtil(Function task,
      {Duration period = const Duration(seconds: 5)}) {
    assert(task != null, "task must not null");
    Stream clock = Stream.periodic(period);
    StreamSubscription streamSubscription = clock.listen((value) {
      task();
    });

    return streamSubscription;
  }
}
