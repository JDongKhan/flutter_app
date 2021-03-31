import 'package:jd_core/network/jd_network_utils.dart';
import 'package:jd_home/models/home_model.dart';

//模拟网络请求数据
class JDRequest {
  static Future<HomeModel> home() async {
    JDNetworkResponse r =
        await JDNetwork.get("http://baidu.com//home.do", mock: true);
    return HomeModel.fromJson(r.data as Map<dynamic, dynamic>);
  }

  static Future<HomeModelList> homeList() async {
    JDNetworkResponse r =
        await JDNetwork.get("http://baidu.com//home_list.do", mock: true);
    return HomeModelList.fromJson(r.data as List<dynamic>);
  }
}
