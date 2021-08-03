import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jd

///web
class WebPage extends StatefulWidget {
  final String url;
  final String title;
  WebPage({this.title, this.url});
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  WebViewProgressController _controller = WebViewProgressController();

  ///通用APP bar 统一后退键
  Widget buildAppBarLeft() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        // color: Colors.red,
        padding: const EdgeInsets.only(left: 20, right: 0),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }

  Widget commonAppBar({
    Widget leftWidget,
    String title,
    List<Widget> rightWidget,
    Color bgColor = Colors.white,
  }) {
    return Container(
      color: bgColor ?? Color.fromRGBO(241, 241, 241, 1),
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
                      fontSize: 24,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //appbar
          commonAppBar(
            title: widget.title,
            leftWidget: buildAppBarLeft(),
          ),
          WebViewProgress(
            controller: _controller,
          ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}

class WebViewProgressController extends ChangeNotifier {
  double progress = 0.0;

  void updateProgress(double progress) {
    this.progress = progress;
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
      if (widget.controller.progress > 0) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.controller.progress > 0,
      child: LinearProgressIndicator(
        value: widget.controller.progress,
        backgroundColor: Colors.grey[100],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[100]),
      ),
    );
  }
}
