import 'dart:isolate';

/// @author jd

Isolate isolate;

Future<dynamic> jd_compute(Function(dynamic) f, dynamic p) async {
  //创建发送方的接收器
  final ReceivePort response = ReceivePort();
  //创建isolate，并且把己方的接收器发送给处理方
  isolate = await Isolate.spawn(_isolate, response.sendPort);
  //等待处理方把它的接收器发过来
  final SendPort sendPort = await response.first as SendPort;
  //开始发消息了
  final ReceivePort answer = ReceivePort();
  sendPort.send([p, f, answer.sendPort]);
  response.close();
  int r = await answer.first;
  answer.close();
  return r;
}

//处理方
void _isolate(SendPort initialReplayTo) {
  //创建接收器
  final port = ReceivePort();
  //告诉发送方己方的接收器
  initialReplayTo.send(port.sendPort);
  //监听对方的信息
  port.listen((message) {
    //来消息了，按接口规范解析数据
    dynamic p = message[0];
    Function(dynamic) f = message[1];
    final send = message[2] as SendPort;
    send.send(f(p));
  });
}
