import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';
import 'package:jd_home/models/home_model.dart';

/// @author jd

class HomeListViewModel extends RefreshListViewModel {
  @override
  Future<List> loadData({int pageNum}) async {
    JDNetworkResponse r =
        await JDNetwork.get("http://baidu.com//home_list.do", mock: true);
    HomeModelList model = HomeModelList.fromJson(r.data as List<dynamic>);
    return model.list;
  }
}
