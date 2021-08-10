import 'package:flutter_app_component/models/image_model.dart';
import 'package:flutter_app_component/models/models.dart';
import 'package:flutter_app_component/models/user.dart';
import 'package:jd_core/network/jd_network_utils.dart';

import 'config/extension_login.dart';
import 'environment.dart';

//模拟网络请求数据
class Request {
//获取版本信息
  static Future<VersionModel> getUpgradeInfo() {
    return Future<VersionModel>.delayed(const Duration(milliseconds: 300), () {
      return VersionModel(
        title: '有新版本v0.1.0，去更新吧！',
        content: '',
        url: 'https://appdownload.html',
        version: '1.0.1',
        force: false,
      );
    });
  }

  static Future<User> login(String account, String password) async {
    JDNetworkResponse r = await JDNetwork.post(
        Environments.servicesPath.loginUrl,
        queryParameters: <String, dynamic>{
          'account': account,
          'password': password
        },
        mock: true);
    return User.fromJson(r.data as Map<dynamic, dynamic>);
  }

  static Future<List<JDImage>> imageList() async {
    JDNetworkResponse r =
        await JDNetwork.get('http://gank.io/api/random/data/福利/100');
    List list = r.data['results'];
    return list?.map((e) => JDImage.fromJson(e)).toList();
  }
}
