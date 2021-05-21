import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_screen_utils.dart';

/// @author jd

typedef JDShareCallback = void Function(String tag);

class JDShareItem {
  JDShareItem(this.tag, {this.icon, this.shareAction});
  final String icon;
  final String tag;
  final JDShareCallback shareAction;
}

void showShareBottomSheet(BuildContext context) {
  List<JDShareItem> shareList = [
    JDShareItem('weChat', icon: 'weChat', shareAction: (String tag) {}),
    JDShareItem('friendsCircle',
        icon: 'friendsCircle', shareAction: (String tag) {}),
    JDShareItem('weibo', icon: 'weibo', shareAction: (String tag) {}),
  ];

  GridView girdView = GridView(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    ),
    children: shareList
        .map((e) => SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(
                JDAssetBundle.getImgPath(e.icon),
              ),
            ))
        .toList(),
  );

  ThemeData currentTheme = Theme.of(context);
  showModalBottomSheet(
    elevation: 0,
    backgroundColor: currentTheme.highlightColor,
    context: context,
    builder: (BuildContext context) => Container(
      width: jd_screenWidth(),
      decoration: BoxDecoration(color: currentTheme.primaryColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            height: jd_getWidth(59),
            padding: EdgeInsets.only(left: jd_getWidth(42)),
            child: Text(
              '分享',
              style: TextStyle(
                fontSize: jd_getSp(32),
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: jd_getWidth(206),
            padding:
                EdgeInsets.only(top: jd_getWidth(33), left: jd_getWidth(33)),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: jd_getWidth(.7),
                  color: currentTheme.dividerColor,
                ),
              ),
            ),
            child: girdView,
          ),
          Container(
            height: jd_getWidth(206),
            padding:
                EdgeInsets.only(top: jd_getWidth(33), left: jd_getWidth(33)),
            alignment: Alignment.topLeft,
            child: Row(
              children: const <Widget>[
                SizedBox(width: 80, height: 80, child: Icon(Icons.share)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: jd_screenWidth(),
              height: jd_getWidth(125),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: jd_getWidth(10),
                    color: currentTheme.backgroundColor,
                  ),
                ),
              ),
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: jd_getSp(36),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
