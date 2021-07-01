import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/single_view_model.dart';
import 'package:jd_home/models/home_model.dart';

/**
 *
 * @author jd
 *
 */

class HomeViewModel extends SingleViewModel {
  @override
  Future loadData() async {
    JDNetworkResponse r =
        await JDNetwork.get("http://baidu.com//home.do", mock: true);
    return HomeModel.fromJson(r.data as Map<dynamic, dynamic>);
  }

  @override
  void onCompleted(data) {}
}
