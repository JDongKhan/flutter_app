import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/models/user.dart';
import 'package:jd_core/utils/jd_storage_utils.dart';

class JDAppUserInfo extends ChangeNotifier {
  JDAppUserInfo() {
    _loadUser();
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
