import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';
import 'package:permission_handler/permission_handler.dart';

/**
 *
 * @author jd
 *
 */

class PrivacySettingPage extends StatefulWidget {
  final String title = "隐私设置";

  @override
  State createState() => _PrivacySettingPageState();
}

class _PrivacySettingPageState extends State<PrivacySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
              child: Text(
                '为提供更好的产品体验，我们在特定的场景可能需要向你申请以下手机系统权限，你可以在手机系统设置页面修改设置',
                style: TextStyle(fontSize: 11, color: Colors.cyan),
              ),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text('允许访问位置', style: TextStyle(fontSize: 14)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('根据你的位置为你推荐当地服务',
                            style: TextStyle(fontSize: 12))),
                    Text(
                      '查看权限说明',
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildTipWidget(Permission.location.status),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text('允许访问相机', style: TextStyle(fontSize: 14)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('为你提供实名认证、扫码、发布动态、修改头像等功能',
                            style: TextStyle(fontSize: 12))),
                    Text(
                      '查看权限说明',
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildTipWidget(Permission.camera.status),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text('允许访问相册', style: TextStyle(fontSize: 14)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text('为你提供发布动态、发布服务、上传案例、修改头像等功能',
                            style: TextStyle(fontSize: 12))),
                    Text(
                      '查看权限说明',
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildTipWidget(Permission.photos.status),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text('隐私保护政策', style: TextStyle(fontSize: 14)),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _buildTipWidget(Future<PermissionStatus> future) {
    return FutureBuilder<PermissionStatus>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
          PermissionStatus state = snapshot.data;
          if (state == null || state.isUndetermined) {
            return Container();
          }
          if (state.isGranted) {
            return const Text('已开启', style: TextStyle(fontSize: 14));
          }
          return const Text('去设置', style: TextStyle(fontSize: 14));
        });
  }
}
