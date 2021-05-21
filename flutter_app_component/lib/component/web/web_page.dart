import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jd

class WebPage extends StatefulWidget {
  final String url;
  WebPage({this.url});
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  ///通用APP bar 统一后退键
  Widget buildAppBarLeft() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.white,
        width: 150,
        height: 90,
        alignment: Alignment.bottomLeft,
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }

  Widget commonAppBar(
      {Widget leftWidget,
      String title,
      List<Widget> rightWidget,
      Color bgColor = Colors.white,
      @required double leftPadding,
      @required double rightPadding}) {
    return Container(
      width: 750,
      height: 115,
      color: bgColor ?? Color.fromRGBO(241, 241, 241, 1),
      padding:
          EdgeInsets.only(bottom: 10, left: leftPadding, right: rightPadding),
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Positioned(
            left: 0,
            child: leftWidget ?? Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: title != null,
              child: Text(
                "$title",
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          if (rightWidget != null) ...rightWidget,
        ],
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
              leftWidget: buildAppBarLeft(), leftPadding: 40, rightPadding: 40),
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
