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
    padding: const EdgeInsets.all(0),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 100,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    ),
    children: shareList
        .map((e) => Container(child: SizedBox(
      width: 10,
      height: 10,
      child: Image.asset(
        'packages/jd_core/assets/${e.icon}.png',
        // package: 'js_core',
      ),
    ),))
        .toList(),
  );

  ThemeData currentTheme = Theme.of(context);
  showModalBottomSheet(
    elevation: 0,
    // backgroundColor: currentTheme.highlightColor,
    context: context,
    builder: (BuildContext context) => Container(
      width: jd_screenWidth(),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: 40,
            padding: EdgeInsets.only(left: jd_getWidth(42),top: 10),
            child: Text(
              '分享',
              style: TextStyle(
                fontSize: jd_getSp(32),
                color: Colors.black,
              ),
            ),
          ),
          Container(
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
            height: 80,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: Row(
              children: const <Widget>[
                SizedBox(width: 80, height: 80, child: Icon(Icons.share,color: Colors.grey,)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: jd_screenWidth(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: currentTheme.dividerColor,
                  ),
                ),
              ),
              child: SafeArea(child: Container(alignment: Alignment.center,height: 60,child: Text(
                '取消',
                style: TextStyle(
                  fontSize: jd_getSp(36),
                  color: Colors.black,
                ),
              ),),),
            ),
          ),
        ],
      ),
    ),
  );
}
