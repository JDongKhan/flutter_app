import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jd

///web page
class WebPage extends StatefulWidget {
  const WebPage({
    this.title,
    @required this.url,
  });
  final String url;
  final String title;
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  final WebViewProgressController _controller = WebViewProgressController();
  WebViewController _webViewController;
  bool _isLocal = false;
  String _url;
  String _title;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    _title = widget.title;
    final bool isRemote =
        widget.url.startsWith('http') || widget.url.startsWith('https');
    _isLocal = !isRemote;
    if (isRemote) {
      _url = widget.url;
    } else {
      if (Platform.isAndroid) {
        _url = 'file://android_asset/flutter_assets/' + widget.url;
      }
    }
    _controller.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          //appbar
          _commonAppBar(
            title: _title,
            leftWidget: _buildAppBarLeft(),
          ),
          WebViewProgress(
            controller: _controller,
          ),
          Expanded(
            child: WebView(
              initialUrl: _url,
              javascriptMode: JavascriptMode.unrestricted, //不限制js
              javascriptChannels: <JavascriptChannel>{_jsBridge(context)},
              onWebViewCreated: (WebViewController controller) {
                _webViewController = controller;
                if (_isLocal) {
                  _loadHtmlAssets()
                      .then((value) => {controller.loadUrl(value)});
                } else {
                  controller.loadUrl(widget.url);
                }
              },
              navigationDelegate: (NavigationRequest navigation) {
                debugPrint('navigationDelegate:$navigation');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                debugPrint('onPageStarted:$url');
                _controller.show();
              },
              onPageFinished: (String url) {
                debugPrint('onPageFinished:$url');
                _controller.dismiss();
                _webViewController.evaluateJavascript('document.title').then(
                      (value) => {
                        if (value != null && value.isNotEmpty)
                          setState(() {
                            _title = value;
                          })
                      },
                    );
              },
              onWebResourceError: (error) {
                debugPrint('onWebResourceError:$error');
                _controller.dismiss();
              },
            ),
          ),
        ],
      ),
    );
  }

  JavascriptChannel _jsBridge(BuildContext context) => JavascriptChannel(
        name: 'jsbridge',
        onMessageReceived: (JavascriptMessage message) async {
          debugPrint(message.message);
        },
      );

  Future<String> _loadHtmlAssets() async {
    String htmlPath = await rootBundle.loadString(widget.url);
    return Uri.dataFromString(
      htmlPath,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
  }

  ///通用APP bar 统一后退键
  Widget _buildAppBarLeft() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        // color: Colors.red,
        padding: const EdgeInsets.only(left: 20, right: 0),
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }

  Widget _commonAppBar({
    Widget leftWidget,
    String title,
    List<Widget> rightWidget,
    Color bgColor = Colors.white,
  }) {
    return Container(
      color: bgColor ?? const Color.fromRGBO(241, 241, 241, 1),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 44,
          // color: Colors.blue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              leftWidget ?? Container(),
              Expanded(
                child: Container(
                  // color: Colors.yellow,
                  child: Text(
                    '$title',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              if (rightWidget != null) ...rightWidget,
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewProgressController extends ChangeNotifier {
  double progress = 0.0;
  bool _show = false;

  void updateProgress(double progress) {
    this.progress = progress;
    notifyListeners();
  }

  void show() {
    _show = true;
    notifyListeners();
  }

  void dismiss() {
    _show = false;
    notifyListeners();
  }
}

class WebViewProgress extends StatefulWidget {
  WebViewProgressController controller;
  WebViewProgress({this.controller});
  @override
  _WebViewProgressState createState() => _WebViewProgressState();
}

class _WebViewProgressState extends State<WebViewProgress> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.controller._show,
      child: LinearProgressIndicator(
        // value: widget.controller.progress,
        backgroundColor: Colors.grey[100],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[100]),
      ),
    );
  }
}
