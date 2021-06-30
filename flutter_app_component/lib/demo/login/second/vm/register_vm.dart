import 'package:flutter/cupertino.dart';
import 'package:flutter_app_component/demo/login/second/model/user_entity.dart';
import 'package:flutter_app_component/demo/login/second/service/login_api.dart';
import 'package:jd_core/view_model/single_view_model.dart';

/*
* 没有多余的手机号了，没法写注册了
*
* */

enum Phase {
  MobileNumber, //输入手机号
  Password, //输入密码
  VerifyCode, //输入验证码
  SetPWD, //设置密码
  NickName, //设置昵称
}

class RegisterVM extends SingleViewModel {
  Phase phase = Phase.MobileNumber;
  updatePhase(Phase phase) {
    this.phase = phase;
    notifyListeners();
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  String phone = '';
  String pwd = '';
  String code = '';

  void setPhone(String text) {
    phone = text;
    notifyListeners();
  }

  void setPWD(String text) {
    pwd = text;
    notifyListeners();
  }

  void setCode(String cd) {
    code = cd;
    notifyListeners();
  }

  String getBtnText() {
    switch (phase) {
      case Phase.MobileNumber:
        return '下一步';
      case Phase.Password:
        return '登录';
      case Phase.VerifyCode:
        return '登录';
        break;
      case Phase.SetPWD:
        // TODO: Handle this case.
        break;
      case Phase.NickName:
        // TODO: Handle this case.
        break;
    }
  }

  final Color redColor = Color.fromRGBO(240, 44, 31, 1);
  final Color redColorA = Color.fromRGBO(240, 44, 31, 0.3);

  Color getBgColor() {
    switch (phase) {
      case Phase.MobileNumber:
        return phone.isEmpty ? redColorA : redColor;
      case Phase.Password:
        return pwd.isEmpty ? redColorA : redColor;
      case Phase.VerifyCode:
        return code.isEmpty ? redColorA : redColor;
        break;
      case Phase.SetPWD:
        // TODO: Handle this case.
        break;
      case Phase.NickName:
        // TODO: Handle this case.
        break;
    }
  }

  void clearPhone() {
    phoneController.clear();
    phone = '';
    notifyListeners();
  }

  void clearPWD() {
    pwdController.clear();
    pwd = '';
    notifyListeners();
  }

  Future<UserEntity> login() async {
    UserEntity userEntity;
    try {
      if (pwd?.isNotEmpty) {
        userEntity = await LoginApi.loginByPhonePWD(phone, pwd);
      } else if (code?.isNotEmpty) {
        userEntity = await LoginApi.loginByPhoneCode(phone, code);
      }
    } catch (e) {
      print(e);
    }
    return userEntity;
  }

  Future<Map> checkAccount() async {
    Map map;
    try {
      map = await LoginApi.checkPhoneExist(phone);
    } catch (e) {
      print(e);
    }
    return map;
  }

  @override
  Future loadData() {
    return null;
  }

  @override
  onCompleted(data) {}
}
