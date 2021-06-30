import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../page/login_page.dart';
import 'user_center_view_model.dart';

/// @author jd

class LoginAPI {
  //尝试打开登录页面
  static Future testLogin(BuildContext context) async {
    UserCenterViewModel userModel = context.read<UserCenterViewModel>();
    if (userModel.hasUser) {
      return null;
    }
    return showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext c) => LoginPage(),
    );
  }
}
