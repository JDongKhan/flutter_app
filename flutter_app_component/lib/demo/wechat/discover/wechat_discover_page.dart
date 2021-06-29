import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/wechat/discover/friend_circle/wechat_friend_circle_page.dart';

import '../../../extension/string_extension.dart';

/// @author jd

class WechatDiscoverPage extends StatefulWidget {
  @override
  _WechatDiscoverPageState createState() => _WechatDiscoverPageState();
}

class _WechatDiscoverPageState extends State<WechatDiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (c) => WechatFriendCirclePage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.asset('weChat'.img),
                  title: Text('朋友圈'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'user_head_0'.img,
                        width: 40,
                        height: 40,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('视频号'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'user_head_6'.img,
                      width: 30,
                      height: 30,
                    ),
                    Text('赞过'),
                    Icon(
                      Icons.arrow_forward_ios,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('扫一扫'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('摇一摇'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('看一看'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('搜一搜'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('直播和附近'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('购物'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('游戏'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListTile(
                leading: Image.asset('weChat'.img),
                title: Text('小程序'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
