import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/single_view_model.dart';

/// @author jd

class CityInfoViewModel extends SingleViewModel<Map> {
  String cityName;
  String weather;
  @override
  Future<Map> loadData() async {
    JDNetworkResponse r = await JDNetwork.get(
        "http://www.weather.com.cn/data/cityinfo/101010100.html");
    return r.data as Map;
  }

  @override
  onCompleted(data) {
    cityName = data['city'];
    weather = data['weather'];
  }
}
