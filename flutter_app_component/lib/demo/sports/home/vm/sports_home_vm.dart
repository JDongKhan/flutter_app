import 'package:flutter_app_component/demo/sports/home/model/sports_content.dart';
import 'package:jd_core/network/jd_network_utils.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';

/// @author jd

class SportsHomeVm extends RefreshListViewModel<SportsContent> {
  @override
  Future<List<SportsContent>> loadData({int pageNum}) async {
    JDNetworkResponse response = await JDNetwork.get(
        'http://baidu.com/sports_infomation_list.do',
        mock: true);
    List list = response.data;
    List<SportsContent> contentList =
        list.map((e) => SportsContent.fromJson(e)).toList();
    return contentList;
  }
}
