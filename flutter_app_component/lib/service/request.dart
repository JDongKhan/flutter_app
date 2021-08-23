import 'package:connectivity/connectivity.dart';
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
        environments.servicesPath.loginUrl,
        queryParameters: <String, dynamic>{
          'account': account,
          'password': password
        },
        mock: true);
    return User.fromJson(r.data as Map<dynamic, dynamic>);
  }

  static Future<List<JDImage>> imageList() async {
    final ConnectivityResult connResult =
        await Connectivity().checkConnectivity();
    if (connResult != null && connResult == ConnectivityResult.none) {
      List<JDImage> _list = [
        JDImage(url: 'video_0'),
        JDImage(url: 'video_1'),
        JDImage(url: 'video_2'),
        JDImage(url: 'video_3'),
        JDImage(url: 'video_4'),
        JDImage(url: 'video_5'),
        JDImage(url: 'video_6'),
        JDImage(url: 'video_7'),
        JDImage(url: 'video_8'),
        JDImage(url: 'video_9'),
        JDImage(url: 'video_10'),
        JDImage(url: 'video_11'),
        JDImage(url: 'video_12'),
      ];
      return _list;
      // throw DioError(error: JDUnreachableNetworkException());
    }

    JDNetworkResponse r =
        await JDNetwork.get('http://gank.io/api/random/data/福利/100');
    List list = r.data['results'];
    return list?.map((e) => JDImage.fromJson(e))?.toList();
  }
}
