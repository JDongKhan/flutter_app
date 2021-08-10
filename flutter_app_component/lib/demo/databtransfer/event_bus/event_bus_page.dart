import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class EventBusPage extends StatefulWidget {
  final String title = "jd_event_bus";

  @override
  _EventBusPageState createState() => _EventBusPageState();
}

class _EventBusPageState extends State<EventBusPage> {
  String msg = '';
  @override
  void initState() {
    bus.on('login', _callback);
    super.initState();
  }

  _callback(arg) {
    if (mounted) {
      setState(() {
        msg = arg;
      });
    }
    print(arg);
  }

  @override
  void dispose() {
    bus.off('login', _callback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(children: <Widget>[
            TextButton(
              onPressed: () {
                bus.emit('login', 'hello');
              },
              child: Text('点击发送信息'),
            ),
            Text(msg),
          ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

typedef void JDEventCallback(arg);

class JDEventBus {
  JDEventBus._internal();
  static final JDEventBus _singleton = JDEventBus._internal();
  factory JDEventBus() => _singleton;
  //保存事件订阅者队列，key：事件名（id），value：对应事件的订阅队列
  var _emap = Map<Object, List<JDEventCallback>>();

  //添加订阅者
  void on(eventName, JDEventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= <JDEventCallback>[];
    _emap[eventName].add(f);
  }

  void off(eventName, [JDEventCallback f]) {
    if (eventName == null) return;
    var list = _emap[eventName];
    if (list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    if (eventName == null) return;
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

//定义一个top-level变量，页面引入该文件后可以直接使用bus
var bus = JDEventBus();
