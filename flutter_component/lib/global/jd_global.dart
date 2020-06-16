import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/models/user.dart';
import 'package:flutter_component/utils/jd_storage_utils.dart';
import 'package:path_provider/path_provider.dart';

class JDGlobal extends ChangeNotifier {
  JDGlobal() {
    _loadUser();
  }

  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

  //初始化
  static Future init(VoidCallback callback) async {
    WidgetsFlutterBinding.ensureInitialized();
    //异步初始化
    delayInit();
    //布局
    callback();
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  //初始化全局信息
  static Future delayInit() async {
    //初始化
    StorageUtil.getInstance();
    temporaryDirectory = await getTemporaryDirectory();
    //初始化bugly
//    FlutterBugly.init(androidAppId: "your android app id",iOSAppId: "your iOS app id");

//    FlutterBugly.setUserId("user id");
//    FlutterBugly.putUserData(key: "key", value: "value");
//    int tag = 9527;
//    FlutterBugly.setUserTag(tag);
//
  }

  User _user;
  User get user {
    if (_user != null) {
      return _user;
    }
    _user = User.fromJson(StorageUtil.getObject("pp_user"));
    return _user;
  }

  void _loadUser() {
    _user = User.fromJson(StorageUtil.getObject("pp_user"));
  }

  void saveUser(User user) {
    _user = user;
    StorageUtil.putObject('pp_user', user);
    notifyListeners();
  }

  void logout() {
    _user = null;
    StorageUtil.putObject('pp_user', null);
    notifyListeners();
  }

  bool get isLogin => _user != null && _user.account != null;
}
