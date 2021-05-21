import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'isolate_util.dart';

/// @author jd

class IsolatePage extends StatefulWidget {
  @override
  _IsolatePageState createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isonlat demo'),
      ),
      body: Column(
        children: [
          Container(
            child: TextButton(
              onPressed: () {
                countEvenAction(100000).then((value) => {
                      print(value),
                    });
              },
              child: Text('isolate'),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> countEvenAction(int n) async {
    // final int r = await jd_compute(_countEven, n);
    final int r1 = await compute(_countEven, n);
    // print('r = $r');
    print('r1 = $r1');
    return r1;
  }

  @override
  void dispose() {
    isolate?.kill(priority: Isolate.immediate);
    super.dispose();
  }
}

int _countEven(dynamic n) {
  int count = 0;
  while (n > 0) {
    if (n % 2 == 0) {
      count++;
      print(count);
    }
    n--;
  }
  return count;
}
