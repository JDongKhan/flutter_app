import 'package:flutter_app_component/demo/sports/home/model/sports_video.dart';
import 'package:jd_core/network/network_utils.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';

/// @author jd

class SportsHomeVideoVM extends RefreshListViewModel<SportsVideo> {
  @override
  Future<List<SportsVideo>> loadData({int pageNum}) async {
    NetworkResponse response =
        await Network.get('http://baidu.com/sports_video_list.do', mock: true);
    List list = response.data;
    List<SportsVideo> contentList =
        list.map((e) => SportsVideo.fromJson(e)).toList();
    return contentList;
  }
}
