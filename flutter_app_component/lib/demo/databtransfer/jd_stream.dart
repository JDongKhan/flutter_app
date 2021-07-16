import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/**
 *
 * @author jd
 *
 */

class JDStreamPage extends StatefulWidget {
  final String title = "jd_stream";

  @override
  _JDStreamPageState createState() => _JDStreamPageState();
}

class _JDStreamPageState extends State<JDStreamPage> {
  StreamController _streamController = StreamController();
  StreamSink get _sink => _streamController.sink;
  Stream get _stream => _streamController.stream;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    _streamSubscription = _stream.listen((event) {
      JDToast.toast(event.toString());
      print(event);
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamController.close();
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
                _streamFromFuture();
              },
              child: Text('Stream.fromFuture(Future<T> future)'),
            ),
            TextButton(
              onPressed: () {
                _streamFromFutures();
              },
              child: Text('Stream.fromFutures(Iterable<Future<T>> futures)'),
            ),
            TextButton(
              onPressed: () {
                _streamFromIterable();
              },
              child: Text('Stream.fromIterable(Iterable<T> elements)'),
            ),
            TextButton(
              onPressed: () {
                // _streamFromPeriodic();
              },
              child: Text(
                  'Stream.periodic(Duration period,[T computation(int computationCount)?])'),
            ),
            TextButton(
              onPressed: () {
                _streamControllerAction();
              },
              child: Text('StreamController'),
            ),
          ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<String> _getData1() async {
    await Future.delayed(
      Duration(
        seconds: 3,
      ),
    );
    return '当前时间为:${DateTime.now()}';
  }

  _streamFromFuture() {
    Stream.fromFuture(_getData1()).listen((event) {
      print('Stream.fromFuture -> $event');
    }).onDone(() {
      print('Stream.fromFuture -> done');
    });
  }

  _streamFromFutures() {
    Stream.fromFutures([_getData1(), _getData1(), _getData1()]).listen((event) {
      print('Stream.fromFuture -> $event');
    }).onDone(() {
      print('Stream.fromFuture -> done');
    });
  }

  _streamFromIterable() {
    var data = [1, 2, '3.toString()', true, false, 6];
    Stream.fromIterable(data).listen((event) {
      print('Stream.fromFuture -> $event');
    }).onDone(() {
      print('Stream.fromFuture -> done');
    });
  }

  _streamFromPeriodic() {
    Stream stream = Stream.periodic(Duration(seconds: 1));
    stream.listen((event) {
      print('Stream.fromFuture -> $event');
    }).onDone(() {
      print('Stream.fromFuture -> done');
    });
  }

  _streamControllerAction() {
    _sink.add({'title': 'JD', 'action': 'tap'});
  }
}
