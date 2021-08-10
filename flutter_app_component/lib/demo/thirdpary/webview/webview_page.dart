import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 *
 * @author jd
 *
 */

class WebViewPage extends StatefulWidget {
  final String title = "jd_webview";

  @override
  State createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.red,
        child: WebView(
          initialUrl: 'https://baidu.com',
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
