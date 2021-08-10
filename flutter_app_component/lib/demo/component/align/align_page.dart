import 'package:flutter/material.dart';

import 'align_demo_page.dart';

/**
 *
 * @author jd
 *
 */

class AlignPage extends StatefulWidget {
  final String title = "Align";

  @override
  State createState() => _AlignPageState();
}

class _AlignPageState extends State<AlignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AlignDemoPage(),
                  ),
                );
              },
              child: Text('Demo'),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: const Align(
                  alignment: Alignment.topRight,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue[50],
                child: const Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment: Alignment.topRight,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue[50],
                child: const Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment: Alignment(2, -1),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: const Align(
                  alignment: FractionalOffset(0.2, 0.6),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
