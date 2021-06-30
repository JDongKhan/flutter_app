import 'package:flutter_app_component/demo/login/second/model/user_entity.dart';
import 'package:jd_core/jd_core.dart';

class LoginApi {
  ///账号、密码登录
  static Future<Map> login(String account, String password) async {
    var response = await JDNetwork.get('/login',
        queryParameters: {'account': account, 'password': password});
    return response == null ? null : response.data;
  }

  ///手机验证码登录
  static Future<UserEntity> loginByPhoneCode(String phone, String code) async {
    var response = await JDNetwork.get('/login/cellphone',
        queryParameters: {'phone': phone, 'code': code});
    if (response == null || response.data.code != 200) {
      return null;
    } else {
      return UserEntity.fromJson(response.data.data);
    }
  }

  ///手机登录
  static Future<UserEntity> loginByPhonePWD(String phone, String pwd) async {
    var response = await JDNetwork.get('/login/cellphone',
        queryParameters: {'phone': phone, 'password': pwd});
    if (response == null || response.data.code != 200) {
      return null;
    } else {
      return UserEntity.fromJson(response.data.data);
    }
  }

  ///检查手机是否已注册
  static Future<Map> checkPhoneExist(String phone) async {
    var response = await JDNetwork.get('/cellphone/existence/check',
        queryParameters: {'phone': phone});
    return response == null ? null : response.data;
  }

  ///发送验证码
  static void sendVerifyCode(String phone) async {
    await JDNetwork.get('/captcha/sent', queryParameters: {'phone': phone});
  }

  ///验证验证码，只有个code  ： 200成功，503 错误
  static Future<bool> verifyCode(String phone, String code) async {
    var response = await JDNetwork.get('/captcha/verify',
        queryParameters: {'phone': phone, 'captcha': code});
    if (response == null) {
      return false;
    } else {
      return response.data['code'] == 200;
    }
  }
}
