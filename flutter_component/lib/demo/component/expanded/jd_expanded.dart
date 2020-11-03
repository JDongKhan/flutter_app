import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDExpandedPage extends StatefulWidget {
  final String title = "expanded";

  @override
  State createState() => _JDExpandedPageState();
}

class _JDExpandedPageState extends State<JDExpandedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(children: <Widget>[_expandedRow()]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Row _expandedRow() {
    return Row(
      children: <Widget>[
        const Text('LeftView',
            style:
                TextStyle(fontSize: 20.0, backgroundColor: Colors.greenAccent)),
        Expanded(flex: 2, child: Container(height: 20.0, color: Colors.yellow)),
        Container(
            color: Colors.blue,
            width: 100.0,
            height: 50.0,
            child: const Text("CenterView",
                style: TextStyle(
                    fontSize: 20.0, backgroundColor: Colors.greenAccent))),
        Expanded(flex: 1, child: Container(height: 20, color: Colors.yellow)),
        Container(
          width: 100,
          height: 50.0,
          alignment: Alignment.center,
          child: const Text(
            "RightView",
            style:
                TextStyle(fontSize: 20.0, backgroundColor: Colors.greenAccent),
          ),
        )
      ],
    );
  }
}
