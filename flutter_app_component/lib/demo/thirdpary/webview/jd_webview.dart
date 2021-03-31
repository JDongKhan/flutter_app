import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 *
 * @author jd
 *
 */

class JDWebViewPage extends StatefulWidget {

  final String title = "jd_webview";

  @override
  State createState() => _JDWebViewPageState();
}

class _JDWebViewPageState extends State<JDWebViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          color: Colors.red,
          child: WebView(initialUrl: 'https://baidu.com',),
        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}