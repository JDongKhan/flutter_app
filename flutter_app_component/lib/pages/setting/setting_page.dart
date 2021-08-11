import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_component/global/jd_appuserinfo.dart';
import 'package:jd_core/style/jd_styles.dart';
import 'package:jd_core/style/jd_theme.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/utils/jd_path_utils.dart';
import 'package:jd_core/utils/jd_toast_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'developer/developer_setting_page.dart';
import 'feedback/feedback_page.dart';
import 'message_setting_page.dart';
import 'privacy_setting_page.dart';

/**
 *
 * @author jd
 *
 */

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State {
  String _cacheSizeStr = "";

  @override
  void initState() {
    super.initState();
    loadCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: myAppBar(
        title: const Text('账户设置'),
      ),
      body: ListTileTheme(
        style: ListTileStyle.drawer,
        child: ListView(
          children: <Widget>[
            _buildCell('偏好设置'),
            _buildCell('消息通知', onTap: () {
              JDNavigationUtil.push(MessageSettingPage());
            }),
            _buildCell('隐私设置', onTap: () {
              JDNavigationUtil.push(PrivacySettingPage());
            }),
            SettingThemeWidget(),
            const Divider(
              height: 1,
            ),
            _buildCell('清除缓存', rightTitle: _cacheSizeStr, onTap: () {
              _clearCache();
            }),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            _buildCell('意见反馈', onTap: () {
              JDNavigationUtil.push(FeedbackPage());
            }),
            _buildCell2(
              '锁定开关',
              rightWidget: Builder(builder: (context) {
                JDTheme theme = context.watch<JDTheme>();
                return Switch(value: true, onChanged: (value) {});
              }),
            ),
            _buildCell('关于我们', onTap: () {
              _showDialog();
            }),
            _buildCell('开发者设置', onTap: () {
              JDNavigationUtil.push(DeveloperSettingPage());
            }),
            if (context.watch<JDAppUserInfo>().isLogin)
              Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: FlatButton(
                  color: Colors.redAccent,
                  highlightColor: Colors.green[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Text('退出'),
                  onPressed: () {
                    _logoutAction();
                  },
                ),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String title, {String rightTitle, Function onTap}) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Container(
              child: ListTile(
                title: Text(title),
                trailing: rightTitle == null
                    ? const Icon(Icons.chevron_right)
                    : Container(
                        alignment: Alignment.centerRight,
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                rightTitle,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            const Icon(Icons.chevron_right)
                          ],
                        ),
                      ),
                onTap: () {
                  onTap?.call();
                },
              ),
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget _buildCell2(String title, {Widget rightWidget, Function onTap}) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Container(
              child: ListTile(
                title: Text(title),
                trailing: rightWidget == null
                    ? const Icon(Icons.chevron_right)
                    : Container(
                        alignment: Alignment.centerRight,
                        width: 80,
                        child: rightWidget,
                      ),
                onTap: () {
                  onTap?.call();
                },
              ),
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  void _showDialog() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      showDialog<dynamic>(
          context: context,
          builder: (context) =>
              _buildAboutDialog(appName, version, buildNumber));
    });
  }

  Widget _buildAboutDialog(String appName, String version, String buildNumber) {
    return AboutDialog(
      applicationIcon: FlutterLogo(),
      applicationName: appName,
      applicationVersion: version,
      applicationLegalese: 'Copyright JD',
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          width: 80,
          height: 80,
          child: Image.asset(JDAssetBundle.getImgPath('head')),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: Text(
            '内部版本号:$buildNumber',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              shadows: [
                Shadow(
                    color: Colors.blue, offset: Offset(.5, .5), blurRadius: 3)
              ],
            ),
          ),
        )
      ],
    );
  }

  void _logoutAction() {
    showDialog<dynamic>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: const Text('您确定要退出登录？?'),
            actions: <Widget>[
              FlatButton(
                child: const Text('取消'),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: const Text('确定'),
                onPressed: () {
                  context.read<JDAppUserInfo>().logout();
                  Navigator.of(context).pop(true); //关闭对话框
                },
              ),
            ],
          );
        });
  }

  /*** 清除缓存 **/
  ///加载缓存
  Future<Null> loadCache() async {
    try {
      Directory tempDir = await JDPathUtils.getAppTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        debugPrint(file.path);
      });*/
      debugPrint('临时目录大小: ' + value.toString());
      setState(() {
        _cacheSizeStr = _renderSize(value);
      });
    } catch (err) {
      print(err);
    }
  }

  /// 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  void _clearCache() async {
    //此处展示加载loading
    try {
      Directory tempDir = await JDPathUtils.getAppTemporaryDirectory();
      //删除缓存目录
      await delDir(tempDir);
      await loadCache();
      JDToast.toast('清除缓存成功');
    } catch (e) {
      print(e);
      JDToast.toast('清除缓存失败');
    } finally {
      //此处隐藏加载loading
    }
  }

  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  ///格式化文件大小
  String _renderSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
}

class SettingThemeWidget extends StatelessWidget {
  SettingThemeWidget();

  @override
  Widget build(BuildContext context) {
    JDTheme theme = context.watch<JDTheme>();
    return Container(
      color: Colors.white,
      child: ExpansionTile(
        title: Text("主题"),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                ...Colors.primaries.map((color) {
                  return Material(
                    color: color,
                    child: InkWell(
                      onTap: () {
                        // var brightness = Theme.of(context).brightness;
                        theme.switchTheme(color: color);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                      ),
                    ),
                  );
                }).toList(),
                Material(
                  child: InkWell(
                    onTap: () {
                      var brightness = Theme.of(context).brightness;
                      theme.switchRandomTheme(brightness: brightness);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).accentColor)),
                      width: 40,
                      height: 40,
                      child: Text(
                        "?",
                        style: TextStyle(
                            fontSize: 20, color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
