import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'likebtn/like_button.dart';

// @deprecated('will be delete')
class WebScaffold extends StatefulWidget {
  const WebScaffold({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
//  WebViewController _webViewController;
//  bool _isShowFloatBtn = false;

  void _onPopSelected(String value) {
    String _title = widget.title;
    switch (value) {
      case "browser":
        JDNavigationUtil.launchInBrowser(widget.url, title: _title);
        break;
      case "collection":
        break;
      case "share":
        String _url = widget.url;
        Share.share('$_title : $_url');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
          LikeButton(
            width: 56.0,
            duration: Duration(milliseconds: 500),
          ),
//          new IconButton(icon: new Icon(Icons.more_vert), onPressed: () {}),
          new PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        value: "browser",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: Colors.grey,
                                    size: 22.0,
                                  ),
                                  VerticalDivider(
                                    width: 10,
                                  ),
                                  Text(
                                    '浏览器打开',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                    ),
                                  )
                                ],
                              ),
                            ))),
//                    new PopupMenuItem<String>(
//                        value: "collection",
//                        child: ListTile(
//                            contentPadding: EdgeInsets.all(0.0),
//                            dense: false,
//                            title: new Container(
//                              alignment: Alignment.center,
//                              child: new Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.collections,
//                                    color: Colours.gray_66,
//                                    size: 22.0,
//                                  ),
//                                  Gaps.hGap10,
//                                  Text(
//                                    '收藏',
//                                    style: TextStyles.listContent,
//                                  )
//                                ],
//                              ),
//                            ))),
                    new PopupMenuItem<String>(
                        value: "share",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                    size: 22.0,
                                  ),
                                  VerticalDivider(
                                    width: 10,
                                  ),
                                  Text(
                                    '分享',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                    ),
                                  )
                                ],
                              ),
                            ))),
                  ])
        ],
      ),
      body: new WebView(
        onWebViewCreated: (WebViewController webViewController) {
//          _webViewController = webViewController;
//          _webViewController.addListener(() {
//            int _scrollY = _webViewController.scrollY.toInt();
//            if (_scrollY < 480 && _isShowFloatBtn) {
//              _isShowFloatBtn = false;
//              setState(() {});
//            } else if (_scrollY > 480 && !_isShowFloatBtn) {
//              _isShowFloatBtn = true;
//              setState(() {});
//            }
//          });
        },
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
//      floatingActionButton: _buildFloatingActionButton(),
    );
  }

//  Widget _buildFloatingActionButton() {
//    if (_webViewController == null || _webViewController.scrollY < 480) {
//      return null;
//    }
//    return new FloatingActionButton(
//        heroTag: widget.title ?? widget.titleId,
//        backgroundColor: Theme.of(context).primaryColor,
//        child: Icon(
//          Icons.keyboard_arrow_up,
//        ),
//        onPressed: () {
//          _webViewController.scrollTop();
//        });
//  }
}
