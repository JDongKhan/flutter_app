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
        title: const Text('发现'),
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
                  leading: const Icon(Icons.child_friendly),
                  title: const Text('朋友圈'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'user_head_0'.img,
                        width: 40,
                        height: 40,
                      ),
                      const Icon(
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
                leading: const Icon(Icons.video_call),
                title: const Text('视频号'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'user_head_6'.img,
                      width: 30,
                      height: 30,
                    ),
                    const Text('赞过'),
                    const Icon(
                      Icons.arrow_forward_ios,
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.scanner_rounded),
                title: Text('扫一扫'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.phone),
                title: Text('摇一摇'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.watch),
                title: Text('看一看'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.search_sharp),
                title: Text('搜一搜'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.near_me),
                title: Text('直播和附近'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.event_busy),
                title: Text('购物'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.games),
                title: Text('游戏'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: const ListTile(
                leading: Icon(Icons.pages_sharp),
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
